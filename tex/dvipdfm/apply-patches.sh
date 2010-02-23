  
SB_PATCHDIR=${CWD}/patches

# These two fix up security issues associated with predicatble temp files
zcat ${SB_PATCHDIR}/${NAME}-0.13.2d-security.patch.gz | patch -p3 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.13.2d-dvipdft-security.patch.gz | patch -p1 -E --backup --verbose || exit 1

# The following patch contains miscellaneous fixes taken from the TeXLive 2007 sources
zcat ${SB_PATCHDIR}/${NAME}-0.13.2d-texlive2007.patch.gz | patch -p1 -E --backup --verbose || exit 1

# This patch fixes a bug seen when handling dvi files with included postscript
# images.
# https://bugzilla.redhat.com/show_bug.cgi?id=453283
# https://bugzilla.redhat.com/show_bug.cgi?id=228078
zcat ${SB_PATCHDIR}/${NAME}-0.13.2d-pdfobj-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-0.13.2d-png14.patch.gz | patch -p1 -E --backup -z .png14 --verbose || exit 1
