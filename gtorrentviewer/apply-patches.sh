
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2b-dso-linking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2b-tracker-details-refresh.patch

set +e +o pipefail
