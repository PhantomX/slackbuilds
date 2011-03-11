
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch0 : use nspr include path from pkg-config istead of a hardcoded one
#          http://code.google.com/p/firetray/issues/detail?id=128
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-fix-nspr-include.patch
# Patch1:  fix wrong unread mail count in thunderbird and seamonkey
#          http://code.google.com/p/firetray/issues/detail?id=120
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-fix-unread-mail-count.patch
# Patch2 : use the system's CXXFLAGS, fix backported from upstream's vcs
#          https://bugzilla.redhat.com/show_bug.cgi?id=621683
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-use-system-cxxflags.patch
# Patch3 : use our own icons instead of the provided ones, except the newmail one
#          http://code.google.com/p/firetray/issues/detail?id=109
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-use-our-icons.patch
# Patch4 : add support for chatzilla
#          http://code.google.com/p/firetray/issues/detail?id=135
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-add-chatzilla-support.patch
#Patch5:   fix for the new way of registering xpcom components
#          http://code.google.com/p/firetray/issues/detail?id=127
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-fix-xpcom-registration.patch

set +e +o pipefail
