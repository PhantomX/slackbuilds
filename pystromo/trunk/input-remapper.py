#!/usr/bin/env python
"""
	Takes input from items of (USB) hardware,
	and remaps the keystrokes to something else.
"""
"""
	Copyright 2007; Mel Collins <mel@raumkraut.net>
	This program is distributed under the terms of the GPL
	(I'll put the proper header in here later)
"""

import time
import signal
from optparse import OptionParser

import config
import mapping
import devices


__version__ = (0, 1, 0)

DEFAULT_CONF = 'default.conf'

############################################################
# Initialisation

# Ideally, I'd like an arbitrary number of values allowable
# for map arguments (and possibly conf arguments, too), but
# the feature isn't implemented in optparse (yet).
optParser = OptionParser(version='%%prog %d.%d.%d' % __version__)
optParser.add_option('-c', '--conf',
		dest='confs', metavar="FILE", action='append',
		help='Use settings from the given file',
		)
optParser.add_option('-m', '--map',
		dest='maps', metavar="FILE", action='append',
		help='Use mappings from the given file',
		)
optParser.add_option('-v', '--verbose', dest='verbose', action='count',
		help='Will print out some information about found devices, etc. Use this option twice to print information about all incoming events, and three times (!) to display outgoing events.',
		)
optParser.set_defaults(verbose=False)

options, args = optParser.parse_args()


# Load in conf file/s
if options.confs:
	confFiles = options.confs
else:
	confFiles = [DEFAULT_CONF]
conf = config.Config(*confFiles)

# Load in mappings
if options.maps:
	keymap = mapping.Mapper(*options.maps)
else:
	# Empty (pass-through) mapper
	keymap = mapping.Mapper()


# Set up output device
output = devices.OutputDevice()
if options.verbose:
	print 'Using output: %s' % str(output)

# ...and the input devices
inputs = []
for device, params in conf.devices.iteritems():
	dev = devices.InputDevice(id=device, keymap=keymap, output=output, **params)
	inputs.append(dev)
	
	if options.verbose:
		print 'Using device: %s' % str(dev)
	



############################################################
# Signal handling setup
## I don't think this actually works at all :(

def shutdown (sigNo=None, frame=None):
	"""
		Initiates the shutdown process.
	"""
	global inputs, quitting
	for device in inputs:
		device.close()
	quitting = True
	

def quit (sigNo=None, frame=None):
	"""
		Stops the main loop at the end of this iteration,
		even if some devices are in the middle of a sequence.
	"""
	global looping, quitting
	looping = False
	quitting = True
	

signal.signal(signal.SIGINT, shutdown)
signal.signal(signal.SIGQUIT, quit)
## Adding SIGHUP to reload conf and mapping files may be nice...



############################################################
# Main loop

looping = True
quitting = False
while looping:
	busyDevices = list(device for device in inputs if device.busy)
	# We should only do a blocking read if no device has anything in it's queue.
	shouldBlock = not (output.busy or busyDevices)
	
	# Crude way of cutting down on CPU usage :/
	## This also prevents some events being interpreted (by X11) out of
	## sequence, I guess because of small timestamp differentials.
	if busyDevices:
		time.sleep(0.01)
	
	# Process those events!
	events = devices.read(blocking=shouldBlock)
	
	if options.verbose > 1:
		for event in events:
			print 'Incoming event: %s' % repr(event)
	
	for device in busyDevices:
		events = device.process()
		
		if options.verbose > 2:
			for event in events:
				print 'Outgoing event: %s' % repr(event)
		
	
	# Actually push the events to the uinput device
	output.process()
	
	if quitting:
		# End the loop only if all the devices have finished.
		if not len(busyDevices):
			looping = False
	

# Destroy and close our output
output.close()

