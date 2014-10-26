
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# http://www.kde.org/info/security/advisory-20140803-1.txt
# unbundle libvncserver, based on
# http://quickgit.kde.org/?p=krfb.git&a=commit&h=1c85dc7d85570c9e3a5fcc57572feb04e57fe6db
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krfb-unbundle_libvncserver.patch
# use system libminilzo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/krfb-system_minilzo.patch

set +e +o pipefail
