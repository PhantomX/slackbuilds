
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
#VCS: git:git://anongit.freedesktop.org/tango/tango-icon-theme
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.90-transparency.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=45803
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.90-rsvg-convert.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
