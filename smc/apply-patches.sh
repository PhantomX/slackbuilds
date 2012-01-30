
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# RPMFusion
# suggested in http://thread.gmane.org/gmane.linux.redhat.fedora.rpmfusion.devel/7651/focus=7665
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/smc-1.9-fix-implicit-linking.patch
# patch from upstream forum
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/smc-fixes-for-cegui-v0-7.diff
# submitted upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/smc-1.9-boost-filesystem-v3.patch

set +e +o pipefail
