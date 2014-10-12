
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7.90-no_mpxj.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.6-librevenge.patch
# https://git.reviewboard.kde.org/r/116611
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-eigen3.patch

set +e +o pipefail
