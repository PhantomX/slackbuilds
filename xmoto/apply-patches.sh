
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .lua52 --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.10-lua52.patch

## Fedora
zcat ${SB_PATCHDIR}/${NAME}-0.3.4-Environment-cstlib.patch.gz | patch -p0 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-0.5.0-Scene-collisioninclude.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.4.0-Environment-string.patch.gz | patch -p0 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-0.4.0-DrawLib-hashmap.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-xmargs-include.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-helpers-text-includes.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.5.0-helpers-log-include.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.9-gcc470.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.10-skip-NULL-collision-objects.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
