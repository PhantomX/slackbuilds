  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libcaca-0.99.beta16-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libcaca-0.99.beta16-libGLU.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  sed -i -e '/RUBY_CFLAGS/s|archdir|rubyhdrdir|g' configure.ac || exit 1
  zcat ${SB_PATCHDIR}/libcaca-0.99.beta16-ruby1.9.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
