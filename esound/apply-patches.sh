
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/esound-0.2.38-drain.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/esound-0.2.38-fix-open-macro.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/remove-confusing-spew.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/esound-nospawn.patch

set +e +o pipefail
