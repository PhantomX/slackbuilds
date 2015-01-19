
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix user local directory case when XDG_CONFIG_HOME is not empty
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pcsx2-user_local_dir-downcase.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/419.patch

set +e +o pipefail
