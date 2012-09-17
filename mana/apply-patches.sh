
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mana-fix-cpp0x-disabling.patch
# Fixes incorrect-fsf-address. 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mana-incorrect-fsf-address-fix.patch
# Fixes file-not-utf8 for AUTHORS file.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mana-utf8-authors-fix.patch
# Fixes the CXX flags getting overwritten by projects cmake files
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mana-dont-overwrite-system-flags-fix.patch

set +e +o pipefail
