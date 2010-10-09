
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.4-multiarchdevel.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/icu.6995.kannada.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.7971.buildfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.7972.buildfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.7932.doublecompare.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.8011.buildfix.patch

set +e +o pipefail
