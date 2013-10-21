
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/pam-1.0.90-redhat-modules.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-std-noclose.patch
zcat ${SB_PATCHDIR}/pam-1.1.0-console-nochmod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pam-1.1.0-notally.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.0-console-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.1-faillock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-noflex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-nouserenv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-console-abstract.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.3-faillock-screensaver.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.5-limits-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-full-relro.patch
# Upstreamed partially
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-pwhistory-helper.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pam-1.1.6-use-links.patch


set +e +o pipefail
