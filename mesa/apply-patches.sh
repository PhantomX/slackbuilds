
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#zcat ${SB_PATCHDIR}/mesa-7.1-link-shared.patch.gz | patch -p1 -E --backup -z .dricore --verbose
# Fedora
zcat ${SB_PATCHDIR}/mesa-no-mach64.patch.gz | patch -p1 -E --backup -z .da --verbose
zcat ${SB_PATCHDIR}/nouveau-legacy-enable.patch.gz | patch -p1 -E --backup -z .nouveau --verbose
zcat ${SB_PATCHDIR}/mesa-7.6-hush-vblank-warning.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nouveau-legacy-update.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.8.1-intel-dri2-damage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/radeon-fix-glCopyTex-Sub-Image-if-user-FBO-is-bound.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-glx1.3-crash-xorg19.patch
[ -d progs/egl ] && patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.8.1-dso.patch
set +e +o pipefail
