
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_LIB_|${LIBDIRSUFFIX}|g" ${SB_PATCHDIR}/${NAME}-scanplugins.patch \
  | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg-2.8.patch

set +e +o pipefail
