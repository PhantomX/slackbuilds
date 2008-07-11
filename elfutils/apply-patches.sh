  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.118-libelf-link.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-strip-copy-symtab.patch.gz | patch -p1 -E --backup --verbose || exit 1

ln -f ${CWD}/testfile16.symtab{,.debug}.bz2 tests || cp -f ${CWD}/testfile16.symtab{,.debug}.bz2 tests

if [ "${SB_COMPAT}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-portability.patch.gz | patch -p1 -E --backup --verbose || exit 1
  sleep 1
  find . \( -name Makefile.in -o -name aclocal.m4 \) -print | xargs touch
  sleep 1
  find . \( -name configure -o -name config.h.in \) -print | xargs touch
fi

zcat ${SB_PATCHDIR}/${NAME}-robustify.patch.gz | patch -p1 -E --backup --verbose || exit 1
