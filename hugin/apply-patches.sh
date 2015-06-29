
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hugin-2013.0.0-lensfun_0.3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hugin-2013.0.0-boost-phoenix3.patch

set +e +o pipefail
