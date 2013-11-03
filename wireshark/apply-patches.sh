
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0001-enable-Lua-support.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0002-Customize-permission-denied-error.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0003-Load-correct-shared-object-name-in-python.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0004-fix-documentation-build-error.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0005-fix-string-overrun-in-plugins-profinet.patch
# Backported from upstream. See https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=8326
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0006-From-Peter-Lemenkov-via-https-bugs.wireshark.org-bug.patch
# Backported from upstream. See also https://bugzilla.redhat.com/1007139
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0007-The-beginning-of-an-openflow-dissector.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0008-adds-autoconf-macro-file.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0009-Restore-Fedora-specific-groups.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0010-Add-pkgconfig-entry.patch
# Will be proposed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0011-Install-autoconf-related-file.patch
# Fedora-specific
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0012-move-default-temporary-directory-to-var-tmp.patch
# Backported to 1.10.x from the patch from this ticket:
# https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=9211
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0013-Added-basic-conversation-support.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
