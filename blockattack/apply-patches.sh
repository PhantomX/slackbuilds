
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-enet13.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-physfs.patch

set +e +o pipefail
