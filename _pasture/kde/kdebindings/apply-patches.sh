  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/kde-python-2.6.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-syntaxfix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-gcc44.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.5.10-libgcj.patch.gz | patch -p0 -E --backup --verbose || exit 1

if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  sed -i -e '/RUBY_ARCHDIR=/s|archdir|rubyhdrdir|g' \
    {korundum,qtruby}/rubylib/*/configure.in.in || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-3.5.10-ruby1.9.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
