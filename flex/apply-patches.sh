
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flex-2.5.35-sign.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flex-2.5.35-hardening.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flex-2.5.35-gcc44.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flex-2.5.35-missing-prototypes.patch

set +e +o pipefail
