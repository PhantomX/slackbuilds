
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fix-configure-typo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-ensure-speex_buffer.h-is-included-in-dist-but-not-in.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/speexdsp-missing-speex_buffer.h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-ensure-resample_neon.h-is-distributed.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/speexdsp-missing-resample_neon.h.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
