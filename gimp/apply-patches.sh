
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# use xdg-open instead of firefox as web browser
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.2-xdg-open.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=559081
# "JPEG Save dialog preview should adjust size units"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.7-jpeg-units.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=556896
# "Dialogs don't get minimized with single image window"
zcat ${SB_PATCHDIR}/gimp-2.6.6-minimize-dialogs.patch.gz | patch -p1 -E --backup --verbose

# backport: fix building with "gold" linker
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.8-gold.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=198367
# https://bugzilla.gnome.org/show_bug.cgi?id=623045
# make script-fu logging IPv6 aware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.10-script-fu-ipv6.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=651002
# avoid traceback in colorxhtml plugin, upstreamed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-colorxhtml.patch
# avoid traceback in pyslice plugin, upstreamed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-pyslice.patch
# backport: work with poppler-0.17, upstreamed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-poppler-0.17.patch
# backport: CVE-2010-4543, CVE-2011-1782
# harden PSP plugin against bogus input data
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-psp-overflow.patch
# backport: CVE-2010-4540, CVE-2010-4541, CVE-2010-4542
# fix buffer overflows in sphere-designer, gfig, lighting plugins
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-CVE-2010-4540,4541,4542.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=711952
# https://bugzilla.gnome.org/show_bug.cgi?id=652280
# guard against crash due to quitting while DND is processed, upstreamed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-shell-dnd-quit-crash.patch
# backport: fix goption warning on startup
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-startup-warning.patch
# CVE-2011-2896: fix heap corruption and buffer overflow, upstreamed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.11-gif-load.patch

set +e +o pipefail
