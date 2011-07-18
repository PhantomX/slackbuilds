
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.14-glutInit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.14-sanitize.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.14-audio.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.14-gcc43.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.14-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/defines-fixbuild.patch
patch -p1 -E --backup -z .broken --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.14-broken-preview.patch

set +e +o pipefail
