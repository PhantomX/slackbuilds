
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.4-spuriouscomma.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-update-to-new-libwpg.patch
# From PLD
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-build.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gc74.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/freetype.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ime-placement.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/poppler-0.26.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
