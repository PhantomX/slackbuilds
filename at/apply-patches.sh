
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-opt_V.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-shell.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-nitpicks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-nowrap.patch

set +e +o pipefail
