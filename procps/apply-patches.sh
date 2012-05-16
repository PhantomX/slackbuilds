
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
