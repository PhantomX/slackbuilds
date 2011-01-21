if [ $(uname -r) == "2.6.17.6" ]; then
	if [ -x sbin/depmod ]; then
	  chroot . /sbin/depmod -a 1> /dev/null 2> /dev/null
	fi
fi