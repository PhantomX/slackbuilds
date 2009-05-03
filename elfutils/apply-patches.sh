  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.118-libelf-link.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-robustify.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_COMPAT}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-portability.patch.gz | patch -p1 -E --backup --verbose || exit 1
  sleep 1
  find . \( -name Makefile.in -o -name aclocal.m4 \) -print | xargs touch
  sleep 1
  find . \( -name configure -o -name config.h.in \) -print | xargs touch
  autoconf -f || exit 1
else
  sed -i.scanf-m -e 's/%m/%a/' src/addr2line.c tests/line2addr.c || exit 1
fi
