
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Linux-PAM-1.1.3-nis.patch
zcat ${SB_PATCHDIR}/pam-1.0.90-redhat-modules.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.0.91-std-noclose.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-console-nochmod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-notally.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-console-fixes.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.1-faillock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.2-noflex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-nouserenv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-console-abstract.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-faillock-screensaver.patch
# Upstreamed patches
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-securetty-console.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-limits-nosetreuid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-limits-range.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-pwhistory-incomplete.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-namespace-private.patch

set +e +o pipefail
