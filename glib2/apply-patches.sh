
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04_homedir_env.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/revert-warn-glib-compile-schemas.patch

### Slackware
# Patch to work around an issue with Java:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Use-Wl-znodelete-for-all-our-libraries.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
