  
SB_PATCHDIR=${CWD}/patches

# From Fedora
zcat ${SB_PATCHDIR}/${PNAME}-2.13.0-detect.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.0-64bit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.0-warnings.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-flac-detect.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-speex.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-libao-first.patch.gz | patch -p1 -E --backup --verbose || exit 1
# The following patches are courtesy of Debian
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-man-pages.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-misc-fixes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-mlutil.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-flac.patch.gz | patch -p1 -E --backup --verbose || exit 1
# end Debian patches
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-ipv6.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-dynlibroot.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-cfgfile-name.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.13.2-missing-protos.patch.gz | patch -p1 -E --backup --verbose || exit 1

# From Gentoo
zcat ${SB_PATCHDIR}/${NAME}-2.13.2-gtk26.patch.gz | patch -p0 -E --backup --verbose || exit 1
