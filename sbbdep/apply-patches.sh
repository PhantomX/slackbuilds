
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Extra library paths from Chinforinfula packages
patch -p0 -E --backup -z .ldpaths --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.5-ldpaths.patch
# https://bitbucket.org/a4z/sbbdep/commits/cdbbd177a6b80f8c1fad377ecd1f808a6ff4249c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fixcircular-dependency.patch

set +e +o pipefail
