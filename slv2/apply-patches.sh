
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/slv2_plugininstance.h_r1948.diff.gz | patch -p2 -E --backup --verbose

set +e +o pipefail
