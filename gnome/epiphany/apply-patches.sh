
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.0.1-home-page.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.17.3-use-pango.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.18.1-default-bookmarks.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=334751
zcat ${SB_PATCHDIR}/${NAME}-2.20.1-wrapped-plugins.patch.gz | patch -p1 -E --backup --verbose || exit 1
