
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Tweak the defaults to make things work properly
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qsynth-fedora-defaults.patch
# Fix DSO linking error
# https://sourceforge.net/tracker/?func=detail&aid=2951295&group_id=93509&atid=604540
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qsynth-linking.patch

set +e +o pipefail
