
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=483025
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/imms-fix-preference-dialog.patch
# Support audacious >= 2.4
patch -p1 -E --backup -z .aud --verbose -i ${SB_PATCHDIR}/imms-audacious.patch

set +e +o pipefail
