
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/exo-0.3.0-x86_64-build.patch.gz | patch -p1 --verbose
# http://patches.ubuntu.com/e/exo/extracted/xubuntu-default-mount-options.patch
zcat ${SB_PATCHDIR}/exo-0.3.105-default-mount-options.patch.gz | patch -p1 --verbose
  
set +e +o pipefail
