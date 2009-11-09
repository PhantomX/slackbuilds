  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/acl.destdir.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/acl-2.2.48-gettext.patch.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1
