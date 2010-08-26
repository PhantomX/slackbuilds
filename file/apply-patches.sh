
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file.etc.file.diff
zcat ${SB_PATCHDIR}/file.quiet.diff.gz | patch -p0 -E --verbose
zcat ${SB_PATCHDIR}/file.short.diff.gz | patch -p1 -E --verbose
if [ "${SB_PYTHON}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/file-4.21-pybuild.diff.gz | patch -p1 -E --verbose
fi

# Fedora
zcat ${SB_PATCHDIR}/file-5.00-devdrv.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/file-5.00-mdmp.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/file-5.03-delta.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/file-5.04-ulaw-segfault.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/file-5.04-ruby-modules.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/file-5.04-filesystem.patch.gz | patch -p1 -E --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-separ.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-squashfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-core-trim.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-retval.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-html-regression.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-zmachine-magic-update.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-core-prpsinfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-python-2.7.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-webm.patch

# Mandriva
zcat ${SB_PATCHDIR}/file-4.24-selinux.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-oracle.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-5.04-ooffice.patch.gz | patch -p1 -E --backup -z .oo --verbose
zcat ${SB_PATCHDIR}/file-4.24-dump.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.24-berkeleydb.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-xen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-svn.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-images.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-apple.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.24-audio.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.20-add-lzma.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.26-xz-container.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-5.00-format-strings.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-5.00-xz-uncompress.patch.gz | patch -p0 -E --backup --verbose

rm -f magic/Magdir/*{~,.orig}

set +e +o pipefail
