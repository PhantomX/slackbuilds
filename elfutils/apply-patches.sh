
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-robustify.patch

if [ "${SB_COMPAT}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-portability.patch
  sleep 1
  find . \( -name Makefile.in -o -name aclocal.m4 \) -print | xargs touch
  sleep 1
  find . \( -name configure -o -name config.h.in \) -print | xargs touch
  autoconf -f || exit 1
else
  sed -i.scanf-m -e 's/%m/%a/' src/addr2line.c tests/line2addr.c || exit 1
fi

set +e +o pipefail
