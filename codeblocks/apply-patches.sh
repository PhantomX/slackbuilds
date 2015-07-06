
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# use system tinyxml, squirrel, astyle libraries
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-13.12-unbundle.patch
# set Fedora specific paths for spellchecker and thesaurus
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-13.12-spellchecker-settings.patch
# wxTreeItemId needs to be initialized with long int
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-wxtreeitemid.patch
# backported change for astyle 2.05
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-13.12-astyle-2.05.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
