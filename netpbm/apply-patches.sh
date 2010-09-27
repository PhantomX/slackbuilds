
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-time.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-message.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-security-scripts.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-security-code.patch
zcat ${SB_PATCHDIR}/${NAME}-nodoc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-gcc4.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-bmptopnm.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-CAN-2005-2471.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-xwdfix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-ppmtompeg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-pamscale.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-glibc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-svgtopam.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-docfix.patch
zcat ${SB_PATCHDIR}/netpbm-ppmfadeusage.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/netpbm-fiasco-overflow.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-lz.patch
zcat ${SB_PATCHDIR}/netpbm-pnmmontagefix.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-noppmtompeg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-cmuwtopbm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-pamtojpeg2k.patch
zcat ${SB_PATCHDIR}/netpbm-libpng14.patch.gz | patch -p0 -E --backup -z .png14 --verbose

set +e +o pipefail
