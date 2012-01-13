
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/return-non-zero-on-fail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/use-path-max-for-alias-names.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-error-path-when-loading-deps.patch
  
set +e +o pipefail
