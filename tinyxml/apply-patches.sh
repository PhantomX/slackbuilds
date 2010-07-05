
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5.3-stl.patch.gz | patch -p1 -E --backup -z .stl --verbose

set +e +o pipefail
