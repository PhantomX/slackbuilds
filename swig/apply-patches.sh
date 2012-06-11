
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig203-rh706140.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig204-rh752054.patch

set +e +o pipefail
