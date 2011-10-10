
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zbar_update_to_617889f8f73.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zbar_dont_user_reserved_dprintf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zbar_use_libv4l.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zbar_choose_supported_format_first.patch

set +e +o pipefail
