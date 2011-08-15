
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-set-default-preferred_names.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2_02_88-do-not-remove-makefile-on-clean.patch

## Gentoo
# bug 318513
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2.02.64-dmeventd-libs.patch
# bug 330373
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2.02.73-locale-muck.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2.02.70-asneeded.patch 
# bug 332905
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-2.02.72-dynamic-static-ldflags.patch

set +e +o pipefail
