
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/11mark_trashed_as_read.patch.gz | patch -p1 -E --backup --verbose
# http://bugs.gentoo.org/show_bug.cgi?id=362297
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.9_notify_crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.9cvs2.patch

set +e +o pipefail
