
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ddd-3.3.11-lang.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ddd-3.3.11-htmlview.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/ddd-3.3.12-rc1-strclass-includes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/machine_code_window_fix.diff

set +e +o pipefail
