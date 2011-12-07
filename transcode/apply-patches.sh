
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.4.external_dv.patch.gz | patch -p1 -E --backup --verbose
rm -f filter/preview/dv_types.h

set +e +o pipefail
