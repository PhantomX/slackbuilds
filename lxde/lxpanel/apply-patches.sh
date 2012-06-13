
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=564746
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.5.9-dsofix.patch

set +e +o pipefail
