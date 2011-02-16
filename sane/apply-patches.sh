
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-pkgconfig.patch
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-open-macro.patch.gz | patch -p1 -E --backup --verbose
if [ "${SB_UACL}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-udev.patch
fi
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-lockdir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.21-automake.patch

set +e +o pipefail
