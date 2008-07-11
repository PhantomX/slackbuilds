  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-5.0.3-ldap-page-control-configure-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-xfn-not-supported.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-basedn-with-spaces-fix-3.patch.gz | patch -p1 -E --backup --verbose || exit 1 
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-nfs4-tcp-only.patch.gz | patch -p1 -E --backup --verbose || exit 1 
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-correct-ldap-lib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-dont-fail-on-empty-master-fix-2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-expire-works-too-hard.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-unlink-mount-return-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-handle-zero-length-nis-key.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.2-init-cb-on-load.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-map-type-in-map-name.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-mount-thread-create-cond-handling.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-check-for-kernel-automount.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.3-nss-source-any.patch.gz | patch -p1 -E --backup --verbose || exit 1
