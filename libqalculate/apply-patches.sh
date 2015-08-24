
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.6-pkgconfig_private.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-htmldir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.7-euroref-daily.patch

set +e +o pipefail
