
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-cln.patch

## upstreamable patches
# fix build using gpsd-2.39
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.2-marble_gpsd_api.patch

set +e +o pipefail
