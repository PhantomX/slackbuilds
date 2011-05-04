
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/PyQt-dso.patch
# fix multilib conflict because of timestamp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.6.2-timestamp-multilib.patch

set +e +o pipefail
