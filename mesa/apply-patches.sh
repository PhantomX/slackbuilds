
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.1-nukeglthread-debug.patch
patch -p1 -E --backup -z .da --verbose -i ${SB_PATCHDIR}/mesa-no-mach64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/legacy-drivers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.10-llvmcore.patch
zcat ${SB_PATCHDIR}/mesa-7.6-hush-vblank-warning.patch.gz | patch -p1 -E --backup --verbose
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.10-swrastg.patch

set +e +o pipefail
