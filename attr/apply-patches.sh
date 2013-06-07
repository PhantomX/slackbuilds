
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# silence compile-time warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-attr-2.4.47-warnings.patch
# use pkg version in $(PKG_DOC_DIR)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-attr-2.4.47-docdir.patch

## Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-687531-fix-missing-ldflags.patch

set +e +o pipefail
