
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

#multilib support
zcat ${SB_PATCHDIR}/pciutils-3.0.2-multilib.patch.gz | patch -p1 -E --backup --verbose

#add support for directory with another pci.ids
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pciutils-dir-d.patch

set +e +o pipefail
