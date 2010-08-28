
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${NAME}-2.30.1-build-gir-1.patch
patch -p1 -E --backup --verbose -i ${NAME}-2.30.1-build-gir-2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30.2-disable-tls1.2.patch

set +e +o pipefail
