
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Bring-the-auth-dialog-to-the-front-when-it-is-shown..patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0016-Autorestart-when-we-crash.-This-way-a-polkit-kde-1-c.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0017-Of-course-we-can-only-set-KCrash-flags-after-KCmdLin.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0019-Remove-unused-Remember-authorization-checkboxes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0020-CCMAIL-echidnaman-kubuntu.org.patch

set +e +o pipefail
