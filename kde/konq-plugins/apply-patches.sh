
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix build with KDE 4.3.80's version of webkitkde (upstream patch)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-babelfish-kwebkitpart.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
