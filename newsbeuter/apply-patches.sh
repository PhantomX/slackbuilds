
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/akrennmair/newsbeuter/pull/157
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8-Improve-solarized-dark-colorscheme.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8-Add-solarized-light-colorscheme.patch

set +e +o pipefail
