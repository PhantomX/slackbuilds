
SB_PATCHDIR=${CWD}/patches

# http://www.kde.org/info/security/advisory-20070730-1.txt
zcat ${SB_PATCHDIR}/koffice-xpdf-CVE-2007-3387.diff.gz | patch -p0 --verbose || exit 1

# http://www.kde.org/info/security/advisory-20071107-1.txt
zcat ${SB_PATCHDIR}/koffice-1.6.3-xpdf2-CVE-2007-4352-5392-5393.diff.gz | patch -p0 --verbose || exit 1

# Fix ODT order
zcat ${SB_PATCHDIR}/KWDocument.cpp.diff.gz | patch -p0 --verbose || exit 1

zcat ${SB_PATCHDIR}/kde-python-2.6.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/koffice-1.6.3-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/220_all_gcc44-glibc210.patch.gz | patch -p3 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/koffice-3.5.10-digest_cc.patch.gz | patch -p3 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/koffice-gmagick.patch.gz | patch -p1 -E --backup --verbose || exit 1
