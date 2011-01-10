
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/psmisc-22.13-peekfd-segv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/psmisc-22.13-fuser-silent.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/psmisc-22.13-killall-pgid.patch

set +e +o pipefail
