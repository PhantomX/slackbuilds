
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# The following two patches will fix some linking errors
# https://github.com/FreeRDP/Remmina/commit/503a008e
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-library-name.patch
# https://github.com/FreeRDP/Remmina/commit/13f20367
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-linker-error.patch
# The following 4 patches are needed to add clipboard support (#818155)
# https://github.com/FreeRDP/Remmina/commit/3ebdd6e7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-add-clipboard-support.patch
# https://github.com/FreeRDP/Remmina/commit/97c2af8c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-clipboard-bugfix.patch
# https://github.com/FreeRDP/Remmina/commit/84327f81
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-some-more-clipboard-fixes.patch
# https://github.com/FreeRDP/Remmina/commit/c1ef3a16
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-disconnect-signal-handler-after-disconnect.patch
# https://github.com/FreeRDP/Remmina/commit/6ee20289
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-crashes-in-some-cases.patch
# https://github.com/FreeRDP/Remmina/commit/b2277827
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-memory-leak.patch
# Fedora bug:   https://bugzilla.redhat.com/show_bug.cgi?id=953678
# upstream bug: https://github.com/FreeRDP/Remmina/issues/63
# upstream fix: https://github.com/FreeRDP/Remmina/commit/1901a1e9
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-typo-when-fitting-window.patch
# Fedora bug:   https://bugzilla.redhat.com/show_bug.cgi?id=834883
# upstream bug: https://github.com/FreeRDP/Remmina/issues/76
# upstream fix: https://github.com/FreeRDP/Remmina/commit/1901a1e9
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-trayicon.patch
# Fedora bug:   https://bugzilla.redhat.com/show_bug.cgi?id=830210
# upstream fix: https://github.com/FreeRDP/Remmina/commit/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-scrolling-in-vnc-plugin.patch
# upstream fix: https://github.com/FreeRDP/Remmina/commit/fe1b698e
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-Also-handle-GDK_SCROLL_SMOOTH.patch
# upstream bug: https://github.com/FreeRDP/Remmina/issues/77
# upstream fix: https://github.com/FreeRDP/Remmina/commit/bed49ad6
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-close-SSH-tunnel-on-disconnect.patch

# Fedora bug:   https://bugzilla.redhat.com/show_bug.cgi?id=864262
# upstream fix: https://github.com/FreeRDP/Remmina/commit/348e01d2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-fullscreen-with-multiple-monitors.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=819976
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-dsofix.patch
# From OpenSUSE. All patches are backport from upstream.
# Thanks to Guido Berhoerster <gber at opensuse dot org>
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-desktop-file.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.0-fix-install-paths.patch

set +e +o pipefail
