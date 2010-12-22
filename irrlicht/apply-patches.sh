
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://irrlicht.sourceforge.net/phpBB2/viewtopic.php?t=24076&highlight=
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.1-optflags.patch
# Get the code compiling
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.1-glext.patch
# Use system libaesgm
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.1-libaesgm.patch
# Use improved fastatof from assimp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.2-fastatof-improvements.patch
# Make libIrrXML.so
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.2-irrXML-shared-library.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng14.patch

set +e +o pipefail
