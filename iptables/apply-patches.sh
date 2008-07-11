  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.8-typo_latter.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1-cloexec.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1-nf_ext_init.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.1-ipv6_network_mask.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Layer7 patch
[ "${SB_L7}" = "YES" ] && \
  zcat ${SB_PATCHDIR}/${NAME}-1.4.1-for-kernel-2.6.20forward-layer7-2.18.patch.gz | \
  patch -p1 -E --verbose || exit 1
chmod 0755 extensions/.layer7-test
