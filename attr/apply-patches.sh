
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/attr.destdir.diff.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/attr-2.4.44-gettext.patch.gz | patch -p0 --verbose --backup --suffix=.orig
# silence compile-time warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/attr-2.4.44-warnings.patch
# getfattr: return non-zero exit code on failure (#660619)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/attr-2.4.44-bz660619.patch
# walk_tree: do not follow symlink to directory with -h (#660613)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/attr-2.4.44-bz660613.patch
# fix typos in attr(1) man page (#669095)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/attr-2.4.44-bz669095.patch

set +e +o pipefail
