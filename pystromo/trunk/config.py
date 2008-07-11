"""
	Stuff for parsing and storing configuration files' data.
"""

from ConfigParser import SafeConfigParser as _ConfParser


class _BaseConfig (object):
	"""
		Parses and stores data from config file/s
	"""
	def __init__ (self, *args):
		"""
			Reads in all the conf files whose filenames have been passed
			in as anonymous arguments. The files will be read in the order
			they were given, so settings in later files will override
			earlier ones.
		"""
		self.clear()
		self.load(args)
		
	
	def __repr__ (self):
		params = (self.__module__, self.__class__.__name__, len(self._files))
		return '<%s.%s using %d files>' % params
	
	def clear (self):
		"""
			Clears out any old config data.
		"""
		self._files = []
		self._parser = _ConfParser()
		
	
	def load (self, filenames):
		"""
			Loads in the configuration data from the given list of
			filenames.
		"""
		self._files = filenames
		
		found = self._parser.read(filenames)
		
		# Output warnings for files which couldn't be used.
		if len(found) < len(filenames):
			for file in filenames:
				if file not in found:
					print 'WARNING: Unable to load "%s"' % file
		
	
	def reload (self):
		"""
			Reloads previously loaded config files.
		"""
		filenames = self._files
		self.clear()
		self.load(filenames)
		
	


class Config (_BaseConfig):
	"""
		Parses and stores program settings and device information.
	"""
	def clear (self):
		"""
			Clears out any old config data.
		"""
		_BaseConfig.clear(self)
		
		self.devices = {}
		
	
	def load (self, filenames):
		"""
			Loads in and parses out the configuration data from the given
			list of filenames.
		"""
		_BaseConfig.load(self, filenames)
		
		parser = self._parser
		self.devices = {}
		for section in parser.sections():
			if section.lower().startswith('device:'):
				# Store a device
				null, name = section.split(':', 1)
				items = dict(parser.items(section))
				# Convert all the numerical values to ints
				for key, value in items.items():
					try:
						# The 0 tells int to guess at the numeric base.
						items[key] = int(value, 0)
					except ValueError:
						# Not a numeric value
						pass
				self.devices[name] = dict(items)
				
			
		
	
