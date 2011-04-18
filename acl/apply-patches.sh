
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/acl.destdir.diff.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/acl-2.2.48-gettext.patch.gz | patch -p0 --verbose --backup --suffix=.orig
# bz #488674
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/acl-2.2.49-setfacl-walk.patch
# bz #467936
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/acl-2.2.49-bz467936.patch
# bz #576550
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/acl-2.2.49-setfacl-restore.patch
# fix typos in setfacl(1) man page (#675451)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/acl-2.2.49-bz675451.patch
# add function acl_extended_file_nofollow() (#692982)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/acl-2.2.49-bz692982.patch

set +e +o pipefail
