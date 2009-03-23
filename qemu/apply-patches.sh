  
SB_PATCHDIR=${CWD}/patches

( cd ${KSRCDIR}
  zcat ${SB_PATCHDIR}/kvm-upstream-ppc.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/kvm-fix-strayR.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/kvm-bios.diff.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1
