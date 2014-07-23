
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/motif-2.3.4-no_demos.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openMotif-2.2.3-uil_lib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openMotif-2.3.0-rgbtxt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/motif-2.3.4-mwmrc_dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/motif-2.3.4-bindings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openMotif-2.3.0-no_X11R6.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
