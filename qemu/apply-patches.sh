
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

ApplyPatch 0001-loader-Add-load_image_gzipped-function.patch
ApplyPatch 0002-aarch64-Allow-kernel-option-to-take-a-gzip-compresse.patch
ApplyPatch 0003-block.curl-adding-timeout-option.patch
ApplyPatch 0004-curl-Allow-a-cookie-or-cookies-to-be-sent-with-http-.patch
ApplyPatch 0005-curl-Don-t-deref-NULL-pointer-in-call-to-aio_poll.patch
ApplyPatch 0006-virtio-pci-enable-bus-master-for-old-guests.patch
ApplyPatch 0007-virtio-pci-fix-migration-for-pci-bus-master.patch

set +e +o pipefail
