
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1
#for patch in $(<debian/patches/series) ;do
#  patch -p1 -i "debian/patches/${patch}" || exit 1
#done

# adds <delay> option that allows netstat to cycle printing through statistics every delay seconds.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-cycle.patch
# Fixed incorrect address display for ipx (#46434)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-ipx.patch
# hostname lookup problems with route --inet6 (#84108)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-inet6-lookup.patch
# various man page fixes merged into one patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-man.patch
# netstat: interface option now works as described in the man page (#61113, #115987)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-interface.patch
# filter out duplicate tcp entries (#139407)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-duplicate-tcp.patch
# don't report statistics for virtual devices (#143981)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-statalias.patch
# clear static buffers in interface.c by Ulrich Drepper (#176714)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-interface_stack.patch
# statistics for SCTP
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-sctp-statistics.patch
# ifconfig crash when interface name is too long (#190703)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-ifconfig-long-iface-crasher.patch
# fixed tcp timers info in netstat (#466845)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-netstat-probe.patch

set +e +o pipefail
