
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.9.13-sec2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.15-bpp16-CVE-2007-3568.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.10-cppflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.15-gmodulehack.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.13-underquoted.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.9.15-lib-bloat.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.15-multilib-config.patch
zcat ${SB_PATCHDIR}/${NAME}.mitshm.render.diff.gz | patch -p1 --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/imlib-1.9.15-libpng15.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/imlib-giflib51.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/imlib-gtk.patch

set +e +o pipefail
