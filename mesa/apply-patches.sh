
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mesa-7.1-link-shared.patch.gz | patch -p1 -E --backup -z .dricore --verbose
zcat ${SB_PATCHDIR}/mesa-no-mach64.patch.gz | patch -p1 -E --backup -z .da --verbose
zcat ${SB_PATCHDIR}/nouveau-legacy-enable.patch.gz | patch -p1 -E --backup -z .nouveau --verbose
zcat ${SB_PATCHDIR}/mesa-7.6-hush-vblank-warning.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
