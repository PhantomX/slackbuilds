# http://www.kde.org/info/security/advisory-20070730-1.txt
zcat ${CWD}/koffice-xpdf-CVE-2007-3387.diff.gz | patch -p0 --verbose || exit 1

# http://www.kde.org/info/security/advisory-20071107-1.txt
zcat ${CWD}/koffice-1.6.3-xpdf2-CVE-2007-4352-5392-5393.diff.gz | patch -p0 --verbose || exit 1
