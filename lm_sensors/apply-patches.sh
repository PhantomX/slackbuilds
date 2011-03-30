
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Configure:
#zcat ${SB_PATCHDIR}/${NAME}.makefile.diff.gz | patch -p1 --verbose

# This is needed because /usr/local is hardcoded in a few places in
# sensor-detect.  A little better searching by that program (like
# perhaps checking $PATH) would be nice, but for now we'll just
# commit the same error by hardcoding the path like we want it.  ;-)
# zcat ${SB_PATCHDIR}/${NAME}.prefix.usr.diff.gz | patch -p1 --verbose

set +e +o pipefail
