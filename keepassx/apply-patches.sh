
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.3-gcc43.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-gcc47.patch
# http://sourceforge.net/tracker/?func=detail&aid=3213306&group_id=166631&atid=839781
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-fix-save.patch

set +e +o pipefail
