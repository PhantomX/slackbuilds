
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Cmake-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-invalid-char.patch
# Upstream deactivated building osgviewerWX for obscure reasons
# Reactivate for now.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Activate-osgviewerWX.patch

set +e +o pipefail
