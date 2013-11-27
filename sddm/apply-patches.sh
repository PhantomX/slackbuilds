
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-git.e707e229-session-list.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-auth.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-savelast.patch

set +e +o pipefail
