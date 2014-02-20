
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.3.9-systemd209.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
