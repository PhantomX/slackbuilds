
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.0.33-freetype.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.0.34-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-loop.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.0.35-overflow.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gd-2.0.35-AALineThick.patch
zcat ${SB_PATCHDIR}/${NAME}-2.0.33-BoxBound.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gd-2.0.35-runtests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gd-2.0.35-security3.patch
zcat ${SB_PATCHDIR}/gd-libpng14.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
