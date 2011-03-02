
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# check return value of theora_encode_init() (#627890)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.8-bz627890.patch
# fix some memory leaks
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.10-leaks.patch
# fix some compile-time warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.10-warnings.patch

set +e +o pipefail
