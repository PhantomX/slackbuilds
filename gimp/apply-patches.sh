
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Don't trip strict overflow warning.
# Upstream commit bc610c8fbd61e9574a2c378829b6ab91047d61b7.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.4-strict-overflow-warning.patch
# Don't have duplicate mime types in desktop file.
# Upstream commit 0ed3b482a422ff684c8921b7de9f44ea7b20345c.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.4-mime-types.patch
# Fix crashes when deleting tags in popups.
# Upstream commit fd4fc76e2114b8ab9341232912c2d19b6160ccd6.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.4-tag-popup-crash.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
