
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-5.9.4-autoopts-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.9.4-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.10.1-build-hang.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.10.1-chmod.patch

set +e +o pipefail
