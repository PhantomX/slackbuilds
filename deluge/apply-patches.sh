
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pt_BR-fix.patch
# Ubuntu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/new_release_check.patch

# Assorted fixes from upstream

set +e +o pipefail
