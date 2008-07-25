  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.8-typo_latter.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1.1-cloexec.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1-nf_ext_init.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1.1-tos_value_mask.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Layer7 patch
[ "${SB_L7}" = "YES" ] && \
  zcat ${SB_PATCHDIR}/${NAME}-1.4.1.1-for-kernel-2.6.20forward-layer7-2.19.patch.gz | \
  patch -p1 -E --verbose || exit 1
