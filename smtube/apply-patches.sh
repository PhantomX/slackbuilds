
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Add quiet output (do not spam xsession-errors)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-quiet.patch

set +e +o pipefail
