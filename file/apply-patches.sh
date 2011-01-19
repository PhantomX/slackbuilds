
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file.etc.file.diff
zcat ${SB_PATCHDIR}/file.quiet.diff.gz | patch -p0 -E --verbose
zcat ${SB_PATCHDIR}/file.short.diff.gz | patch -p1 -E --verbose

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-zip64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.05-python-magic.patch

# Mandriva
zcat ${SB_PATCHDIR}/file-4.24-selinux.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-oracle.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.05-ooffice.patch
zcat ${SB_PATCHDIR}/file-4.24-berkeleydb.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-xen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-svn.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-images.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-apple.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.05-audio.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.05-xz-container.patch

rm -f magic/Magdir/*{~,.orig}

set +e +o pipefail
