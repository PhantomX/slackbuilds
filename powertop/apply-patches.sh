
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-always-create-params.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-tunable-overflow-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-auto-tune-crash-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-navigate-hint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-baytrail-no-c7.patch

set +e +o pipefail
