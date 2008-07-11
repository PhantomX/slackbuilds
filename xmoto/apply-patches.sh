
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.3.4-Environment-cstlib.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.3.4-Scene-collisioninclude.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.4.0-Environment-string.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.4.0-DrawLib-hashmap.patch.gz | patch -p0 -E --backup --verbose || exit 1
