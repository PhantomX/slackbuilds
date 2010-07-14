
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/amarok-2.2.1.90-qtscript_not_required.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/amarok-2.3.1-glib26_signals_fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Move-some-code-in-TrayIcon-class.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Some-TrayIcon-changes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-TrayIcon-Do-not-update-cover-each-time-we-update-the.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Minor-Remove-redundant-debug-output.-Update-copyrigh.patch

set +e +o pipefail
