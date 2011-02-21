
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Relocate output on user's Desktop
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-conf.patch
zcat ${SB_PATCHDIR}/${NAME}-desktop.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
