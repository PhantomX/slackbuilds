
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/xfig-3.2.5a-default-apps.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig-3.2.5-fhs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig.3.2.5-modularX.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig.3.2.5-Xaw3d.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig-3.2.5-enable-Xaw3d.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig-3.2.5-urwfonts.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/xfig-3.2.5-debian.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xfig-3.2.5b-fix-eps-reading.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xfig-3.2.5b-fix-fig-buffer-overflow.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xfig-3.2.5b-mkstemp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xfig-3.2.5b-libpng-1.5.patch

  
set +e +o pipefail
