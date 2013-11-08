
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-optflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-fix-pubkey-size-divisions.patch

set +e +o pipefail
