
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/DevIL-1.7.5-allegropicfix.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.7.5-il_endian_h.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/DevIL-1.7.8-CVE-2009-3994.patch
zcat ${SB_PATCHDIR}/devil-libpng14.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
