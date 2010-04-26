
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# bad hack
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.4-ldap-x86_64-hack.patch

# Move .conduit files from share to lib (for the sake of multilib)
# This patch effects other parts of evolution.spec and so is necessary
# for a successful build.
zcat ${SB_PATCHDIR}/${NAME}-2.5.4-fix-conduit-dir.patch.gz | patch -p1 -E --backup --verbose

# RH bug #176400
zcat ${SB_PATCHDIR}/${NAME}-2.9.1-im-context-reset.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
