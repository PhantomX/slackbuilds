
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Adapted from ROSA patch
patch -p1 -E --backup -z .exosip400 --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-exosip-4.0.0.patch

set +e +o pipefail
