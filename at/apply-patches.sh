
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.13-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-opt_V.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-shell.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.13-nitpicks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.13-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.13-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-nowrap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.12-fix_no_export.patch

set +e +o pipefail
