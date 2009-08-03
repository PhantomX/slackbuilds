  
SB_PATCHDIR=${CWD}/patches

# patching missing struct ucred in glibc headers
# http://bugzilla.gnome.org/show_bug.cgi?id=525228
zcat ${SB_PATCHDIR}/gamin-0.1.9-ucred-headers.patch.gz | patch -p01 -E --backup --verbose || exit 1
