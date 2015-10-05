
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Fedora bug: https://bugzilla.redhat.com/show_bug.cgi?id=746063
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.8.1-Fix-pager-scroll.patch
# http://sourceforge.net/p/lxde/bugs/758
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.8.1-fix-rightclick-segv.patch
# https://sourceforge.net/p/lxde/bugs/753/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.8.1-panel-size-at-left.patch

### Arch AUR
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.8.0-gtk3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-netstat-some-fixes-for-GTK3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-batt-plugin-Fix-with-GTK3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-launchtaskbar-fix-scroll-event-with-GTK3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Replace-old-unused-commands.patch
rm -f data/ui/*.ui

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
