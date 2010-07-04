
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
zcat ${SB_PATCHDIR}/${NAME}_4.58-install.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-9.13-nostrip.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/9.04-kde4.patch

set +e +o pipefail
