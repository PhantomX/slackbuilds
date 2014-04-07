
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dosbox-0.74-gcc46.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dosbox-0.74-init-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dosbox-0.74-formatsecurity.patch

set +e +o pipefail
