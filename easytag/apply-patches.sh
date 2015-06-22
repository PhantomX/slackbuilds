
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1226671
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.7-fix-browser-key-event-crash.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1231502
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.7-fix-flac-header-read-crash.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
