
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-version-override.patch
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-1.41.0-shared_ptr_serialization.patch.gz | patch -p1 -E --backup --verbose
# The patch may break c++03, and there is therefore no plan yet to include
# it upstream: https://svn.boost.org/trac/boost/ticket/4999
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.46.1-signals-erase.patch
# http://comments.gmane.org/gmane.comp.lib.boost.devel/214323
# Has been fixed on Boost trunk (will be fixed in Boost-1.47:
#  https://svn.boost.org/trac/boost/changeset/68725)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.46.1-spirit.patch

set +e +o pipefail
