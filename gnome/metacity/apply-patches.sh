
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=558723
zcat ${SB_PATCHDIR}/stop-spamming-xsession-errors.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=135056
zcat ${SB_PATCHDIR}/dnd-keynav.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.gnome.org/show_bug.cgi?id=588119
zcat ${SB_PATCHDIR}/Should-set-RestartStyleHint-to-RestartIfRunning-when.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=336750
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/screenshot-forkbomb.patch

# fedora specific patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/workspaces.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fresh-tooltips.patch

# https://bugzilla.gnome.org/show_bug.cgi?id=567528
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Allow-explicit-raises-from-same-client-not-just-sa.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=445447
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Allow-applications-to-raise-windows-when-raise_on_cl.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=598995
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Dont-focus-ancestor-window-on-a-different-workspac.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599097
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/For-mouse-and-sloppy-focus-return-to-mouse-mode-on.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599248
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Add-nofocuswindows-preference-to-list-windows-that.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599261
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Add-a-newwindowsalwaysontop-preference.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=577576
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Dont-warn-about-a-missing-session-file.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=559816
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/metacity-2.28-empty-keybindings.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=604319
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/metacity-2.28-xioerror-unknown-display.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=611260
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libs.patch

set +e +o pipefail
