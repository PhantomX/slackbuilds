
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/perl-Tk-widget.patch.gz | patch -p0 -E --backup --verbose

perl -pi -e \
"s,\@demopath\@,/usr/doc/${PNAME}-${VERSION}/demos,g" \
                demos/widget
# modified version of http://ftp.de.debian.org/debian/pool/main/p/perl-tk/perl-tk_804.027-8.diff.gz
zcat ${SB_PATCHDIR}/perl-Tk-debian.patch.gz | patch -p1 -E --backup --verbose
# fix segfaults as in #235666 because of broken cashing code
zcat ${SB_PATCHDIR}/perl-Tk-seg.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
