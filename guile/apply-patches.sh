
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/guile-1.8.7-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/guile-1.8.7-testsuite.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/guile-1.8.8-deplibs.patch

set +e +o pipefail
