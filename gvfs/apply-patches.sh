  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.99.2-archive-integration.patch.gz | patch -p0 -E --backup --
zcat ${SB_PATCHDIR}/${NAME}-obexftp-updated-apis-2.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=530654
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-reverse-map-fuse-paths.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=528320 (from svn)
zcat ${SB_PATCHDIR}/${NAME}-1.0.2-no-generic-icons.patch.gz | patch -p0 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=468946
zcat ${SB_PATCHDIR}/${NAME}-1.0.2-guess_content_type.patch.gz | patch -p0 -E --backup --verbose || exit 1
