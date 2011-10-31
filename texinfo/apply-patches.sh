
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.12-zlib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.13a-data_types.patch.gz | patch -p1 -E --backup --verbose
# Patch2: is already upstream
zcat ${SB_PATCHDIR}/${NAME}-4.13a-mosdo-crash.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.13a-powerpc.patch
# Patch4: accepted by upstream, bz579263
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.13a-help-index-segfault.patch
# Patch5: already upstream, bz641534
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.13a-texi2dvi-regexp.patch
# Patch6: already upstream, bz651314
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.13a-makeinfo-sectioning.patch

set +e +o pipefail
