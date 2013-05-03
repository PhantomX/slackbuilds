
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/gapan/spkg
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Show-the-slack-desc-and-doinst.sh-files-in-the-packa.patch

set +e +o pipefail
