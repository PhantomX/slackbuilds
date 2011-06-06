
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-no-execmem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-icu44.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/replace-switch-with-given-when.patch

set +e +o pipefail
