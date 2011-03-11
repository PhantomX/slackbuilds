
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/mplayer-1.0pre8-config.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
