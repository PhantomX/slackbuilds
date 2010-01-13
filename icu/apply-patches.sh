
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.4-multiarchdevel.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}.icu6284.strictalias.patch.gz | patch -p1 -E --backup --verbose 
zcat ${SB_PATCHDIR}/icu.6995.kannada.patch.gz | patch -p1 -E --backup --verbose 
zcat ${SB_PATCHDIR}/icu.icu7039.badextract.patch.gz | patch -p1 -E --backup --verbose 
zcat ${SB_PATCHDIR}/icu.6969.pkgdata.patch.gz | patch -p1 -E --backup --verbose 
zcat ${SB_PATCHDIR}/icu.XXXX.buildfix.patch.gz | patch -p1 -E --backup --verbose 
