
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup -z .suffix --verbose -i ${SB_PATCHDIR}/${NAME}-suffix.patch
# https://sourceforge.net/tracker2/?func=detail&aid=2599980&group_id=90275&atid=593019
patch -p0 -E --backup -z .cfits --verbose -i ${SB_PATCHDIR}/${NAME}-cfitsio.patch

set +e +o pipefail
