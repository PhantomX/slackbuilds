
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Gentoo
patch -p3 -E --backup --verbose -i ${SB_PATCHDIR}/add_missing_stdbool_h_include.patch

set +e +o pipefail
