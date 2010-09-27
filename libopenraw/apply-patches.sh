
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .pixbufloaderdir --verbose -i ${SB_PATCHDIR}/${NAME}-0.0.8-pixbufloaderdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Support-partially-PEF-from-Pentax-K20D.patch

set +e +o pipefail
