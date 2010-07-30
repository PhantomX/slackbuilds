
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
bzcat ${SB_PATCHDIR}/${NAME}-0.20-sys.patch.bz2 | patch -p3 -E --backup --verbose

set +e +o pipefail
