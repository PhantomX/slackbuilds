
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.2.0-redhat-modules.patch
zcat ${SB_PATCHDIR}/pam-1.1.0-console-nochmod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-notally.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.2.1-faillock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-noflex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-nouserenv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.5-limits-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-full-relro.patch
# Upstreamed partially
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-pwhistory-helper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.2.0-use-elinks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-audit-user-mgmt.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
