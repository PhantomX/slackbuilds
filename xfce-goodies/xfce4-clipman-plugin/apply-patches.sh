
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://git.xfce.org/panel-plugins/xfce4-clipman-plugin/commit/?id=d06e35ee62a0477adc84b5d7aeb29e348bb0b813
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.3-fix-possible-NULL-values.patch

set +e +o pipefail
