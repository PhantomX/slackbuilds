
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fixes #643380
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sysstat-10.0.0-cpu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sysstat-10.0.0-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sysstat-10.0.0-iostat_hr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sysstat-10.0.0-ru.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sysstat-10.0.0-cifs_fopen.patch

set +e +o pipefail
