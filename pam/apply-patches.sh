  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/pam-1.0.90-redhat-modules.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.0.91-std-noclose.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.1.0-cracklib-authtok.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.1.0-console-nochmod.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.1.0-notally.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.1.0-xauth-context.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/pam-1.1.0-console-fixes.patch.gz | patch -p1 -E --backup --verbose || exit 1
