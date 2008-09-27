  
SB_PATCHDIR=${CWD}/patches

# bad hack
zcat ${SB_PATCHDIR}/${NAME}-1.4.4-ldap-x86_64-hack.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Move .conduit files from share to lib (for the sake of multilib)
# This patch effects other parts of evolution.spec and so is necessary
# for a successful build.
zcat ${SB_PATCHDIR}/${NAME}-2.5.4-fix-conduit-dir.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Remove gnome-common macros from configure.in.
# We do not ship gnome-common (or at least we're not supposed to).
zcat ${SB_PATCHDIR}/${NAME}-2.7.1-no-gnome-common.patch.gz | patch -p1 -E --backup --verbose || exit 1

# RH bug #176400
zcat ${SB_PATCHDIR}/${NAME}-2.9.1-im-context-reset.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Don't ship broken plugins as stable
zcat ${SB_PATCHDIR}/${NAME}-2.23.4-experimental-plugins.patch.gz | patch -p1 -E --backup --verbose || exit 1
