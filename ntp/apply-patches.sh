
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# ntpbz #802
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-sleep.patch
# add support for dropping root to ntpdate
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p4-droproot.patch
# ntpbz #779
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p3-bcast.patch
# align buffer for control messages
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-cmsgalign.patch
# link ntpd with -ffast-math on ia64
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-linkfastmath.patch
# ntpbz #759
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-retcode.patch
# ntpbz #2085
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-rootdisp.patch
# ntpbz #2309
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-hexpw.patch
# ntpbz #898
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p4-htmldoc.patch
# ntpbz #1402
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-updatebclient.patch
# add missing nanokernel macros
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-nano.patch
# fix precision calculation on fast CPUs
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.4p7-getprecision.patch
# ntpbz #1408
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p1-logdefault.patch
# add option -m to lock memory
[ "${SB_AUTOGEN}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-mlock.patch
# ntpbz #2506
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-refreshroute.patch
# ntpbz #2040
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-identlen.patch
# ntpbz #1670
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p3-broadcastdelay.patch
# ntpbz #1671
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-delaycalib.patch
# ntpbz #2019
[ "${SB_AUTOGEN}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-pwcipher.patch
# ntpbz #2320
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-noservres.patch
# ntpbz #2612
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-monwarn.patch
# ntpbz #2538
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-testmain.patch
# ntpbz #1232
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-nanoshm.patch
# ntpbz #2666
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-cve-2014-9294.patch
# ntpbz #2665
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-cve-2014-9293.patch
# ntpbz #2667
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-cve-2014-9295.patch
# ntpbz #2670
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ntp-4.2.6p5-cve-2014-9296.patch

( cd ntpstat-${NSVER}
  # handle unknown clock types
  zcat ${SB_PATCHDIR}/ntpstat-0.2-clksrc.patch.gz | patch -p2 -E --backup --verbose
  # process first packet in multipacket response
  zcat ${SB_PATCHDIR}/ntpstat-0.2-multipacket.patch.gz | patch -p2 -E --backup --verbose
  # use current system variable names
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ntpstat-0.2-sysvars.patch
  # print synchronization distance instead of dispersion
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ntpstat-0.2-maxerror.patch
  # fix error bit checking
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ntpstat-0.2-errorbit.patch
)

set +e +o pipefail
