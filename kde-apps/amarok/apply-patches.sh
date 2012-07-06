
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#zcat ${SB_PATCHDIR}/amarok-2.2.1.90-qtscript_not_required.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# https://bugs.kde.org/show_bug.cgi?id=290123
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-kde48_context_view.patch 
# Load all tracks from XSPF using MetaProxy.
# https://bugs.kde.org/show_bug.cgi?id=295199
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-proxy_loading.patch 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-liblastfm1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-ffmpeg-0.11.patch


set +e +o pipefail
