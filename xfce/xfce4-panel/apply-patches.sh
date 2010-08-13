
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/xfce4-panel-4.6.0-defaults.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xfce4-panel-4.6.1-multilib.patch

set +e +o pipefail
