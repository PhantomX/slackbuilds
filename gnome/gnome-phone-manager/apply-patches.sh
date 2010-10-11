
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Update-copy-paste-code.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-GSeal-compilation.patch

set +e +o pipefail
