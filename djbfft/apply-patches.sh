
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/djbfft-build.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/djbfft-stdlib.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/djbfft-0.76-shared.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
