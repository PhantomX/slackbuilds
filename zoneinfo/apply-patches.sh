
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .makefile --verbose -i ${SB_PATCHDIR}/timezone-data-2013h-makefile.patch

if [ "${SB_JAVA}" = "YES" ] ;then
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/javazic-fixup.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/javazic-exclusion-fix.patch
fi

set +e +o pipefail
