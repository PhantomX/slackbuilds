  
SB_PATCHDIR=${CWD}/patches

#truncate too long names (#205948)
zcat ${SB_PATCHDIR}/pciutils-2.2.4-buf.patch.gz | patch -p1 -E --backup --verbose || exit 1

#don't segfault on systems without PCI bus (#84146)
zcat ${SB_PATCHDIR}/pciutils-2.1.10-scan.patch.gz | patch -p1 -E --backup --verbose || exit 1

#use pread/pwrite, ifdef check is obsolete nowadays
zcat ${SB_PATCHDIR}/pciutils-havepread.patch.gz | patch -p1 -E --backup --verbose || exit 1

#multilib support
zcat ${SB_PATCHDIR}/pciutils-3.0.2-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1

#add support for directory with another pci.ids
zcat ${SB_PATCHDIR}/pciutils-dir-d.patch.gz | patch -p1 -E --backup --verbose || exit 1
