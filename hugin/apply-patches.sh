
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# lensfun 0.3.0
sed -i -e '/LF_DIST_MODEL_FOV1/d' src/hugin_base/lensdb/LensDB.cpp
# http://sourceforge.net/p/hugin/hugin/ci/e237d6d1d87354f974d37a95ba52dbd9666dd310/
sed -i 's/\r//' src/tools/ParseExp.cpp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hugin-boost156.patch

set +e +o pipefail
