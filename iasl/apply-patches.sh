
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/debian-big_endian.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/debian-unaligned.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/name-miscompare.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/asllookup-miscompare.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/re-enable-big-endian.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/int-format.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/f23-harden.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/asllookup-ppc64.patch

set +e +o pipefail
