
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-optflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-fix-pubkey-size-divisions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-segfaults-reference-leaks-in-error-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-typo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fix-segfault-if-Crypto.Random.new-is-missing.patch

set +e +o pipefail
