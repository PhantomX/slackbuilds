
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Slackware / upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Revert-Minor-code-refactoring.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-some-libdir-scripts-stuff-missed-in-4d87a25ea0af.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Filter-out-the-kdm-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Apply-overlooked-prefix-lib-libdir-substitution.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
