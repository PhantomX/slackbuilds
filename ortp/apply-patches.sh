
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ortp-0.16.1-retval.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ortp-0.16.5-unusedvar.patch

set +e +o pipefail
