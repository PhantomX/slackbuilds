
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
# Fix issue with definition of LOCALE_DECIMAL_POINTS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8-fix-locale-decimal-points.patch
# Fix build with Mesa 10
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.1-mesa10.patch

set +e +o pipefail
