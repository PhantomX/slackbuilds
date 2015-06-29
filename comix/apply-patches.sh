
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/comix-4.0.4-archive-directory-removed.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/comix-4.0.4-thumb-imaging_error.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/comix-4.0.4-gettext-usrmove.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/comix-4.0.4-pathname2url-utf8.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/comix-4.0.4-import-PIL-for-Image.patch

set +e +o pipefail
