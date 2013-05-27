
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-ng-3.3.7-testsuite-reverting-bogus-commit-unix-exp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-ng-3.3.7-segv-file2str-read-zero-bytes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-ng-3.3.7-top-inoculated-against-a-window-manager-like-screen.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-off-by-one-in-pmap.patch

set +e +o pipefail
