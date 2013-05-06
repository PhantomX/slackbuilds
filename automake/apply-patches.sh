
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.13.1-pax-hangs.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

if [ "${SB_AUTOGEN}" = "YES" ] && [ -x /usr/bin/autoreconf ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.13.1-non-existing-m4-dir.patch
fi

set +e +o pipefail
