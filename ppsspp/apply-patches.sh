
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-noupdate.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.9.1-ffmpeg2.2.patch

set +e +o pipefail
