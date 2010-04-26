
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/sane-backends-1.0.20-open-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-hal.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_UACL}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.20-udev.patch
fi
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-lockdir.patch.gz | patch -p1 -E --backup --verbose || exit 1

set +e +o pipefail
