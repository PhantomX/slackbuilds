
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/imap-2007-paths.patch.gz | patch -p1 -E --backup --verbose
# See http://bugzilla.redhat.com/229781 , http://bugzilla.redhat.com/127271
zcat ${SB_PATCHDIR}/imap-2004a-doc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/imap-2007e-overflow.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/imap-2007e-shared-slk.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/imap-2007e-authmd5.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
