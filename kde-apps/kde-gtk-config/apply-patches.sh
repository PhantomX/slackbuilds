
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Support to ~/.gtkrc-2.0.mine for extra settings
patch -p0 -E --backup -z .mine --verbose -i ${SB_PATCHDIR}/${NAME}-add-dotmine.patch

set +e +o pipefail
