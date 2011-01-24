
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.4-guess2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.7-libs.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-0.9.3-xen.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-sect.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-iaperf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nehalem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-amd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-westmere.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.qt4.diff

set +e +o pipefail
