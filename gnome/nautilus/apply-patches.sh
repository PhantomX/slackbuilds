
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Disable automount
zcat ${SB_PATCHDIR}/${NAME}-2.24.0-noautomount.patch.gz | patch -p0 -E --backup --verbose
# Some changes to default config
zcat ${SB_PATCHDIR}/${NAME}-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.7-rhconfig.patch.gz | patch -p1 -E --backup --verbose

# from upstream
zcat ${SB_PATCHDIR}/rtl-fix.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gvfs-desktop-key-2.patch

# http://bugzilla.gnome.org/show_bug.cgi?id=519743
zcat ${SB_PATCHDIR}/${NAME}-filetype-symlink-fix.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
