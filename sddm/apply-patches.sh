
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-0.11-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Inherit-path-environment-variables-from-parent.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-Don-t-cast-QByteArray-to-char.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-Disable-greeters-from-loading-KDE-s-debug-hander.patch

set +e +o pipefail
