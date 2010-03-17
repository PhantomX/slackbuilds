
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=319096
# zcat ${SB_PATCHDIR}/${NAME}-2.15.5-fedora-docs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.13.2-add-mime-handling.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-use-pango.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=592762
zcat ${SB_PATCHDIR}/ellipsis.patch.gz | patch -p1 -E --backup --verbose

# Fix build with xulrunner-1.9.2
zcat ${SB_PATCHDIR}/${NAME}-2.28.1-system-nspr.patch.gz | patch -p0 -E --backup --verbose
# Fix issues introduced by xulrunner 1.9.2, bug 301831.
zcat ${SB_PATCHDIR}/${NAME}-2.28.1-xul192-compat.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
