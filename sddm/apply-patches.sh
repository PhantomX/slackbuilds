
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-0.11-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Replace-signal-handling-method-of-detecting-X-startu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0019-handle-merge-of-libsystemd-journal-libsystemd-for-sy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0028-Correcting-small-typo-in-TextConstants.qml.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0034-fix-typo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0045-Provid-the-role-needsPassword-in-UserModel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0049-Set-showPassword-according-to-needsPassword-role-in-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0050-Add-a-note-about-needsPassword-role-and-shadow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0059-Add-new-platformTheme-key-to-themes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0069-Clock-Do-not-hardcode-date-format.patch

set +e +o pipefail
