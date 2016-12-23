
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .makefile --verbose -i ${SB_PATCHDIR}/timezone-data-2016g-makefile.patch

if [ "${SB_JAVA}" = "YES" ] ;then
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/javazic-fixup.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/javazic-exclusion-fix.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/rebase-01.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/rebase-02.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/7090844.patch
  patch -p0 -E --backup --verbose -d javazic -i ${SB_PATCHDIR}/7133138.patch
fi

set +e +o pipefail
