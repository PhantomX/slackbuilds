
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# ntpbz #802
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-sleep.patch
# add support for dropping root to ntpdate
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-droproot.patch
# ntpbz #779
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-bcast.patch
# align buffer for control messages
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-cmsgalign.patch
# link ntpd with -ffast-math on ia64
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-linkfastmath.patch
# ntpbz #1134
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p2-tentative.patch
# ntpbz #759
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-retcode.patch
# ntpbz #992
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-rtnetlink.patch
# fix script used to generate man pages
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-html2man.patch
# ntpbz #898
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-htmldoc.patch
# add missing nanokernel macros
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-nano.patch
# fix precision calculation on fast CPUs
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.4p7-getprecision.patch
# ntpbz #1408
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-logdefault.patch
# add option -m to lock memory
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p2-mlock.patch

( cd ntpstat-${NSVER}
  # handle unknown clock types
  zcat ${SB_PATCHDIR}/ntpstat-0.2-clksrc.patch.gz | patch -p2 -E --backup --verbose
  # process first packet in multipacket response
  zcat ${SB_PATCHDIR}/ntpstat-0.2-multipacket.patch.gz | patch -p2 -E --backup --verbose
  # use current system variable names
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ntpstat-0.2-sysvars.patch
  # print synchronization distance instead of dispersion
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ntpstat-0.2-maxerror.patch
)

set +e +o pipefail
