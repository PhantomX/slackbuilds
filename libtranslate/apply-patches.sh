
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.99-charsetparse.diff.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99-condfix.diff.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99-int64.diff.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99-postmarker.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99-services.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99-libsoup24.diff.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99-fix-modules.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99-strip_tags.patch

set +e +o pipefail
