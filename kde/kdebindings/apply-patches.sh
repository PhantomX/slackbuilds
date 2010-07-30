
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 

zcat ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff.gz | patch -p1 --verbose

patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-fix-build-against-trunk.patch 

# https://bugs.kde.org/show_bug.cgi?id=244697
patch -p1 --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.92-fix-build.patch

set +e +o pipefail
