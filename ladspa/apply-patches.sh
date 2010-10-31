
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ladspa-sdk-1.13-properbuild.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ladspa-sdk-1.13-asneeded.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ladspa-sdk-hardcode-path.patch.gz | patch -p0 -E --backup --verbose
sed -i -e 's:-sndfile-play*:@echo Disabled \0:' src/makefile

set +e +o pipefail
