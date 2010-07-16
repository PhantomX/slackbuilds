
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/setuptools-0.6_rc7-noexe.patch.gz | patch -p0 -E --backup -z .orig --verbose

set +e +o pipefail
