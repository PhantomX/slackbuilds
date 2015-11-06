
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.3-pmap_callit.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.3-xp_auth.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
