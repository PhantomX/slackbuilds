"""
	Wrappers around various ioctl functionality, for use with the
	USB input remapper.
	
	Especially useful top-level functions:
		getInputFiles
		getOutputFile
		grabDevices
"""

import os
import fcntl
import struct

import constants as const

# System settings
# You can customise, or preferably add to, these to work on distros
# with different filesystem layouts.

# This is a list of all glob() paths to all the input-event device nodes.
INPUT_PATHS = ['/dev/input/event*']
# A list of all the possible locations for the uinput device.
# The first one which exists is the one which is used.
UINPUT_DEVICES = ['/dev/uinput', '/dev/input/uinput', '/dev/misc/uinput']


def getInputNodes ():
	"""
		Returns a list of all the filesystem device nodes
		which we could use as input.
	"""
	from glob import glob
	
	devices = []
	for pattern in INPUT_PATHS:
		for node in glob(pattern):
			try:
				fd = os.open(node, os.O_RDWR | os.O_NONBLOCK)
			except OSError:
				#info = sys.exc_info()
				#print 'Unable to open %s: %s' % (event, str(info[1]))
				continue
			devices.append(fd)
			
	return devices
	

def getDeviceId (fd):
	"""
		Returns a tuple of device information, given an open file descriptor
		for an input-event device node.
		The information returned is a 4-tuple of:
			(busType, vendorId, productId, version)
	"""
	vals = fcntl.ioctl(fd, const.EVIOCGID, const.EVIOCGID_BUFFER)
	return struct.unpack(const.EVIOCGID_FORMAT, vals)
	

def getDeviceName (fd):
	"""
		Returns the textual 'name' of the given input-event device.
	"""
	name = fcntl.ioctl (fd, const.EVIOCGNAME_512, const.EVIOCGNAME_512_BUFFER)
	# Even though we remove null characters, some devices
	# (I'm looking at you "Honey Bee  Nostromo SpeedPad2 ")
	# may have trailing spaces in the device name.
	return name.strip('\0')
	

def matchInputNodes (name=None, bus=None, vendor=None, product=None, version=None):
	"""
		Returns a list of all the input-event device nodes which match
		the given parameters.
	"""
	inputs = []
	for fd in getInputNodes():
		vals = getDeviceId (fd)
		# This is the most readable way of doing this I can think of.
		# We run through checks to see if fd is invalid,
		# rather than checking validity explicitly.
		if name and getDeviceName(fd) != name:
			pass
		elif bus and vals[0] != bus:
			pass
		elif vendor and vals[1] != vendor:
			pass
		elif product and vals[2] != product:
			pass
		elif version and vals[3] != version:
			pass
		else:
			# All invalidity checks failed
			inputs.append(fd)
			continue
		
		# Clean up unwanted files
		os.close(fd)
		
	
	return inputs
	

def grabDevices (*args):
	"""
		Grabs all the given devices, so we alone receive input events.
		Each device should be a separate anonymous argument.
	"""
	for fd in args:
		## Using 0 will un-grab it.
		fcntl.ioctl(fd, const.EVIOCGRAB, 1)
	

def getUInput ():
	"""
		Returns the file descriptor for the uinput device-node.
		The node will be opened for unbuffered write access only.
	"""
	for loc in UINPUT_DEVICES:
		try:
			uinput = os.open(loc, os.O_WRONLY)
		except OSError:
			continue
		# Successfully opened, so we use this one
		break
	else:
		raise LookupError ('no uinput device-nodes found')
	
	return uinput
	

def initUInputDevice (fd):
	"""
		Initialises a uinput node for use as an output for our events.
	"""
	# Write custom device info
	USER_DEVICE_FORMAT = "80sHHHHi" + 'I'*64*4
	# These are: device name, bus type, vendor, product, version, ff_effects_max
	USER_DEVICE_DATA = [
			"Pystromo Input Remapper",
			const.BUS_USB,
			1,
			1,
			1,
			0,
			]
	# This handles absmax, absmin, absfuzz and absflat
	## I actually don't know why they're so large, or what they're for
	USER_DEVICE_DATA += [0] * 64*4
	
	os.write(fd, struct.pack(USER_DEVICE_FORMAT, *USER_DEVICE_DATA))
	
	# Set the event bits
	UI_SET_EVBIT   = 0x40045564
	# Register all the event type/codes we may want to send
	for eType in [const.EV_KEY, const.EV_REL, const.EV_ABS]:
		fcntl.ioctl(fd, UI_SET_EVBIT, eType)
		# We register all the codes we know
		for code in const.CODES[eType]:
			fcntl.ioctl(fd, UI_SET_EVBIT + eType, code)
	
	# Create the device
	UI_DEV_CREATE  = 0x5501
	fcntl.ioctl(fd, UI_DEV_CREATE)
	

def destroyUInputDevice (fd):
	"""
		"Destroy" a device previously created on a uinput node.
		NB. I have no idea if this is at all necessary...
	"""
	UI_DEV_DESTROY = 0x5502
	fcntl.ioctl(fd, UI_DEV_DESTROY)
	

def getOutputDevice ():
	"""
		Returns a file descriptor for the device-node we're going to output
		manipulated events to.
	"""
	fd = getUInput()
	initUInputDevice(fd)
	return fd
	
