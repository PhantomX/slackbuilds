
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.3.4-Environment-cstlib.patch.gz | patch -p0 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-0.5.0-Scene-collisioninclude.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.4.0-Environment-string.patch.gz | patch -p0 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-0.4.0-DrawLib-hashmap.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-xmargs-include.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-helpers-text-includes.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-helpers-log-include.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/xmoto-libpng-1.4.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
