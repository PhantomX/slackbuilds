
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Move-safe-table-params-wipe-into-function-which-allo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Re-check-flags-after-DM-device-creations.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Properly-allow-activation-of-discard-even-if-dm_cryp.patch
  
set +e +o pipefail
