
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/SDL-1.2.10-byteorder.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.13-libdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.11-dynamic-esd.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-x11dyn64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-disable_yasm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.13-dynamic-pulse.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_PA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.13-audiodriver.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi

# submitted upstream:
# http://bugzilla.libsdl.org/show_bug.cgi?id=698
zcat ${SB_PATCHDIR}/SDL-1.2.13-pa-rewrite.patch.gz | patch -p1 -E --backup --verbose || exit 1
# submitted upstream:
# http://bugzilla.libsdl.org/show_bug.cgi?id=699
zcat ${SB_PATCHDIR}/SDL-1.2.13-rh484362.patch.gz | patch -p1 -E --backup --verbose || exit 1
# upstream patch:
# qemu-kvm segfaults on startup in SDL_memcpyMMX/SSE
zcat ${SB_PATCHDIR}/SDL-1.2.13-rh487720.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/SDL-1.2.11-libcaca-new-api.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libsdl-1.2.11-xinerama-head-0.patch.gz | patch -p1 -E --backup --verbose || exit 1
