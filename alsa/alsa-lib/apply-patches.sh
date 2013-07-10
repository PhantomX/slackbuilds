
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/alsa-lib-1.0.24-config.patch
zcat ${SB_PATCHDIR}/alsa-lib-1.0.14-glibc-open.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/alsa-lib-1.0.16-no-dox-date.patch.gz | patch -p1 -E --backup --verbose

## upstream patches

set +e +o pipefail
