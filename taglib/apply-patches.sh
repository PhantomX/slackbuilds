
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/taglib-1.5rc1-multilib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fixed-ABI-breakage-in-TagLib-String.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Rewrote-ByteVector-replace-simpler.patch

set +e +o pipefail
