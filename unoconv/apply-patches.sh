
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-a-broken-export-option-and-add-V-as-alternative-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-python3-added-compatibility.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-update-FSF-address.patch

set +e +o pipefail
