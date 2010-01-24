  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/file.quiet.diff.gz | patch -p0 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/file.short.diff.gz | patch -p1 -E --verbose || exit 1
if [ "${SB_PYTHON}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/file-4.21-pybuild.diff.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/file-5.00-devdrv.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/file-5.00-mdmp.patch.gz | patch -p1 -E --v.gz | patch -p1 -E --verbose || exit 1erbose || exit 1
zcat ${SB_PATCHDIR}/file-5.03-delta.patch.gz | patch -p1 -E --verbose || exit 1

zcat ${SB_PATCHDIR}/file-4.24-selinux.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.21-oracle.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-5.04-ooffice.patch.gz | patch -p1 -E --backup -z .oo --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.24-dump.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.24-berkeleydb.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.20-xen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.21-svn.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.20-images.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.20-apple.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.24-audio.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.20-add-lzma.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-4.26-xz-container.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-5.00-format-strings.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/file-5.00-xz-uncompress.patch.gz | patch -p0 -E --backup --verbose || exit 1

rm -f magic/Magdir/*{~,.orig}
