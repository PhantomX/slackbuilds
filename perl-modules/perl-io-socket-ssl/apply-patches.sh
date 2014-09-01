
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.997-use-system-default-cipher-list.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.997-use-system-default-SSL-version.patch

set +e +o pipefail
