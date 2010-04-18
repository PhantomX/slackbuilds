
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.4-multiarchdevel.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}.icu6284.strictalias.patch.gz | patch -p1 -E --backup --verbose 
zcat ${SB_PATCHDIR}/icu.6995.kannada.patch.gz | patch -p1 -E --backup --verbose 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.XXXX.buildfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.icu7567.libctest.patch

set +e +o pipefail
