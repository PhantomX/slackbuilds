
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-pam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-opt_V.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-shell.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-nitpicks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-nowrap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-fix_no_export.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-mailwithhostname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-usePOSIXtimers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-help.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/at-3.1.14-wrong_format.patch

set +e +o pipefail
