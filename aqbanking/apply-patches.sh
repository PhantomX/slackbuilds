
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .pkgconfig --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.0-pkgconfig.patch
zcat ${SB_PATCHDIR}/${NAME}-2.1.0-conflict.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
