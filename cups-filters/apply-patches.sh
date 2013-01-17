
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/poppler_buildfix.diff

set +e +o pipefail
