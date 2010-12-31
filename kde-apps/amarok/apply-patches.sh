
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/amarok-2.2.1.90-qtscript_not_required.patch.gz | patch -p1 -E --backup --verbose

## upstream patches

set +e +o pipefail
