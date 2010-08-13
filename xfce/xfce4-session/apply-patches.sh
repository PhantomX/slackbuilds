
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/xfce4-session-4.5.92-hide-tips.patch.gz | patch -p1 --verbose
# http://patches.ubuntu.com/x/xfce4-session/extracted/01_correct_shadows.patch
zcat ${SB_PATCHDIR}/xfce4-session-4.6.1-correct-shadows.patch.gz | patch -p1 --verbose

set +e +o pipefail
