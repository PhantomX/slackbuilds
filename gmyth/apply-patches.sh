
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-remove-debug.patch.gz | patch -p0 -E --backup --verbose
( cd ${SRCDIRU}
  zcat ${SB_PATCHDIR}/${NAME}-upnp-remove-warning.patch.gz | patch -p0 -E --backup --verbose
) || exit 1


set +e +o pipefail
