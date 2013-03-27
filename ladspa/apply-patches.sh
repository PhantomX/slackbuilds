
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ladspa-sdk-1.13-properbuild.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ladspa-sdk-1.13-asneeded.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ladspa-sdk-1.13-no-LD.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/ladspa-1.13-plugindir.patch
sed -i -e 's:-sndfile-play*:@echo Disabled \0:' src/makefile

set +e +o pipefail
