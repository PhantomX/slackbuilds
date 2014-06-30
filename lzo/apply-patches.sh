
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup -z .configure --verbose -i ${SB_PATCHDIR}/lzo-2.05-configure.patch
### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/configure-2.07.patch

set +e +o pipefail
