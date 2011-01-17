
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.1.0-gcc44.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-src-0.1.0-no_phonon.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-src-0.1.0-qmake_target.path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kde_phonon443.patch
## debian patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/memory_alignment_fix.diff

set +e +o pipefail
