
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.6.1-xfce4-panel-4.7.patch
# http://git.xfce.org/panel-plugins/xfce4-datetime-plugin/commit/?id=7770996215eeca0f5e5f89bdcc4df94acc1d9415
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.6.1-tooltips.patch

set +e +o pipefail
