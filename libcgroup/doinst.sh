#!/bin/sh
config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Leave any new rc files with the same permissions as the old ones:
if [ -e etc/rc.d/rc.cgconfig ]; then
  if [ -x etc/rc.d/rc.cgconfig ]; then
    chmod 755 etc/rc.d/rc.cgconfig.new
  else
    chmod 644 etc/rc.d/rc.cgconfig.new
  fi
fi
if [ -e etc/rc.d/rc.cgred ]; then
  if [ -x etc/rc.d/rc.cgred ]; then
    chmod 755 etc/rc.d/rc.cgred.new
  else
    chmod 644 etc/rc.d/rc.cgred.new
  fi
fi

# Then config() them:
config etc/rc.d/rc.cgconfig.new
config etc/rc.d/rc.cgred.new

# config() the other configuration files:
config etc/cgconfig.conf.new
config etc/cgred.conf.new
config etc/cgrules.conf.new
config etc/cgsnapshot_blacklist.conf.new

# If there are already installed config files, get rid of the .new ones.
# There will still be fresh samples in the docs.
rm -f etc/cgconfig.conf.new etc/cgred.conf.new etc/cgrules.conf.new etc/cgsnapshot_blacklist.conf.new

