
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-inttypes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multilib.patch


set +e +o pipefail
