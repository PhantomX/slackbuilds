
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-set-default-preferred_names.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2_02_73-fix-exported-syms.patch

set +e +o pipefail
