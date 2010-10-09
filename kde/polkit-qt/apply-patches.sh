
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.95.1-install-cmake-find.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.96.1-fix-deprecated-warnings.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.96.1-null-checking.patch

set +e +o pipefail
