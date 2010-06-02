
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}-4.4.0-no-rpath.patch.gz | patch -p1 -E --backup -z .no-rpath --verbose
#sed -i -e 's!COMMAND smokegen!COMMAND ${PROJECT_BINARY_DIR}/generator/bin/smokegen${CMAKE_EXECUTABLE_SUFFIX}.shell!g' -e 's/WORKING_DIRECTORY/DEPENDS smokegen WORKING_DIRECTORY/g' \
  #smoke/*/CMakeLists.txt

zcat ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff.gz | patch -p1 --verbose

patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-fix-build-against-trunk.patch 

set +e +o pipefail
