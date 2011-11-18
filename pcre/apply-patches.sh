
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/pcre-7.3-multilib.patch.gz | patch -p1 -E --backup --verbose
# Fix look-behind regression, in upstream after 8.20.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.20-lookbehind.patch
# Fix other look-behind regression, in upstream after 8.20.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.20-lookbehind-2.patch

set +e +o pipefail
