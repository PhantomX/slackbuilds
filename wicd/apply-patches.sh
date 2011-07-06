
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.0-remove-WHEREAREMYFILES.patch
# Use cPickle instead of deepcopy in configmanager.py
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.0-deepcopy.patch

set +e +o pipefail
