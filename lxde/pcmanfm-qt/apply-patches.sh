
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/lxde/pcmanfm-qt/commit/b467d4f96bd1d5525f59186551196fd5964c56b8.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.0-libfm120-icontheme.patch

set +e +o pipefail
