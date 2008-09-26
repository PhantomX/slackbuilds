
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.20.0-default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.23.90-securitytoken.patch.gz | patch -p1 -E --backup --verbose || exit 1
# add support for gnome-keyring to the pam stack
#zcat ${SB_PATCHDIR}/gnome-keyring.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-blank-by-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.20.0-selinux-permit.patch.gz | patch -p1 -E --backup --verbose || exit 1
