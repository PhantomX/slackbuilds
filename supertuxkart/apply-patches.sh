
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-fhs.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-irrlicht-typo.patch
# http://sourceforge.net/apps/trac/supertuxkart/ticket/500
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-irrlicht-fix.patch

set +e +o pipefail
