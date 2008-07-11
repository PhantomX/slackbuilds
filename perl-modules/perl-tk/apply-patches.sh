  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/perl-Tk-widget.patch.gz | patch -p0 -E --backup --verbose || exit 1

perl -pi -e \
"s,\@demopath\@,/usr/doc/${PNAME}-${VERSION}/demos,g" \
                demos/widget || exit 1
# modified version of http://ftp.de.debian.org/debian/pool/main/p/perl-tk/perl-tk_804.027-8.diff.gz
zcat ${SB_PATCHDIR}/perl-Tk-debian.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix segfaults as in #235666 because of broken cashing code
zcat ${SB_PATCHDIR}/perl-Tk-seg.patch.gz | patch -p1 -E --backup --verbose || exit 1

# fix gif overflow in tk see CVE-2006-4484 and CVE-2007-6697 or #431518 and
# #431529
zcat ${SB_PATCHDIR}/perl-Tk-gif.patch.gz | patch -p0 -E --backup --verbose || exit 1
