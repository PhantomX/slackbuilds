
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Remove xinetd support 
patch -p1 -E --backup -z .slk --verbose -i ${SB_PATCHDIR}/${NAME}-0.101.8-slk.patch

set +e +o pipefail
