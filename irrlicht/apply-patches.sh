
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://irrlicht.sourceforge.net/phpBB2/viewtopic.php?t=24076&highlight=
patch -p1 -E --backup -z .optflags --verbose -i ${SB_PATCHDIR}/${NAME}-1.8-optflags.patch
# Get the code compiling
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8-glext.patch
# Use system libaesgm
patch -p1 -E --backup -z .libaesgm --verbose -i ${SB_PATCHDIR}/${NAME}18-libaesgm.patch
# Make libIrrXML.so
patch -p1 -E --backup -z .irrXML --verbose -i ${SB_PATCHDIR}/${NAME}-1.8-irrXML-shared-library.patch

set +e +o pipefail
