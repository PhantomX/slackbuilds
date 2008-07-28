  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.4-missing-protos.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3.4-remove_britney_references.patch.gz | patch -p1 -E --backup --verbose || exit 1
rm -f ./src/menubg_britney.png
zcat ${SB_PATCHDIR}/${NAME}-1.3.4-svn-fixes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3.4-man.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3.4-bz441527.patch.gz | patch -p1 -E --backup --verbose || exit 1
