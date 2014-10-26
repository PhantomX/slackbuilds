
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/pam-1.0.90-redhat-modules.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-std-noclose.patch
zcat ${SB_PATCHDIR}/pam-1.1.0-console-nochmod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-notally.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.1-faillock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-noflex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-nouserenv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.5-limits-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-full-relro.patch
# Upstreamed partially
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-pwhistory-helper.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-use-links.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.7-tty-audit-init.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-translation-updates.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-canonicalize-username.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-cve-2013-7041.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-cve-2014-2583.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-loginuid-container.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-opasswd-tolerant.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-audit-grantor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-man-dbsuffix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-limits-check-process.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-limits-docfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.8-audit-user-mgmt.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
