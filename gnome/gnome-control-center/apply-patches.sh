
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-default.patch

# http://bugzilla.gnome.org/show_bug.cgi?id=545075 
zcat ${SB_PATCHDIR}/slab-icon-names.patch.gz | patch -p0 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=555591
zcat ${SB_PATCHDIR}/default-layout-toggle.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.gnome.org/show_bug.cgi?id=597066
zcat ${SB_PATCHDIR}/shell-markup.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/best-shapes.patch.gz | patch -p1 -E --backup --verbose

# call the Fedora/RHEL graphical passwd changing apps
# zcat ${SB_PATCHDIR}/control-center-2.25.2-passwd.patch.gz | patch -p1 -E --backup --verbose
# zcat ${SB_PATCHDIR}/control-center-2.25.2-gecos.patch.gz | patch -p1 -E --backup --verbose
# change default preferred apps to programs we ship
zcat ${SB_PATCHDIR}/default-applications.patch.gz | patch -p1 -E --backup --verbose

# update the shell common tasks to desktop files we ship
zcat ${SB_PATCHDIR}/shell-common-tasks.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
