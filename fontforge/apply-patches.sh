
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-20090224-pythondl.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20120731-pdf-bounds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20120731-pdf-filters.patch

set +e +o pipefail
