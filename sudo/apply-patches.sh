
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# don't strip
zcat ${SB_PATCHDIR}/sudo-1.6.7p5-strip.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sudo-1.8.14b3-ldapconfpatch.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sudo-1.8.14b4-docpassexpire.patch

set +e +o pipefail
