
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if ! [ -r /usr/include/linux/videodev.h ] ;then
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/lives-1.4.3-nov4l1.patch
fi

set +e +o pipefail
