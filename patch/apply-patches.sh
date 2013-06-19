
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/patch-remove-empty-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/patch-args.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/patch-args-segfault.patch

set +e +o pipefail
