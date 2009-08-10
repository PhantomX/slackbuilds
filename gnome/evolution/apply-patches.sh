  
SB_PATCHDIR=${CWD}/patches

# bad hack
zcat ${SB_PATCHDIR}/${NAME}-1.4.4-ldap-x86_64-hack.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Move .conduit files from share to lib (for the sake of multilib)
# This patch effects other parts of evolution.spec and so is necessary
# for a successful build.
zcat ${SB_PATCHDIR}/${NAME}-2.5.4-fix-conduit-dir.patch.gz | patch -p1 -E --backup --verbose || exit 1

# RH bug #176400
zcat ${SB_PATCHDIR}/${NAME}-2.9.1-im-context-reset.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Add missing GConf schemas
zcat ${SB_PATCHDIR}/${NAME}-2.26.3-missing-gconf-schemas.patch.gz | patch -p1 -E --backup --verbose || exit 1
