
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Slackware/Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/26source_encoding.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/52fix_screen_utf8_nfd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/58-show-encoding-hardstatus.patch

## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-screenrc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-E3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-suppress_remap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.1-crypt.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
