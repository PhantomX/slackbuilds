if [ -r bin/bash ]; then
  mv bin/bash bin/bash.old
fi
mv bin/bash2.new bin/bash
if [ -f bin/bash.old ]; then
  rm -f bin/bash.old
fi
if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi
if fgrep "/bin/bash" etc/shells 1> /dev/null 2> /dev/null ; then
  true
else
  echo "/bin/bash" >> etc/shells
fi
( cd usr/bin ; rm -rf bash )
( cd usr/bin ; ln -sf /bin/bash bash )
