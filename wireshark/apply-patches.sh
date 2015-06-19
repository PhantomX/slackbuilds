
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0001-enable-Lua-support.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0002-Customize-permission-denied-error.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0003-fix-string-overrun-in-plugins-profinet.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0004-adds-autoconf-macro-file.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0005-Restore-Fedora-specific-groups.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0006-Add-pkgconfig-entry.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0007-Install-autoconf-related-file.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0008-move-default-temporary-directory-to-var-tmp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0010-gdk.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
