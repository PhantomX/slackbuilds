
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/${NAME}-3.2.7-selinux.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-misc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-FAQ.patch
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-selinux-workaround.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-noproc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-pseudo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-0x9b.patch
# 157725 - sysctl -A returns an error
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-sysctl-writeonly.patch
# 161449 - "top" ignores user and system toprc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-top-rc.patch
# 161303 - 'top' failed when remove cpus
# 186017 - Top "Cpu0" line never updates on single processor machine
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-remcpu.patch.gz | patch -p1 -E --backup --verbose
# Selinux
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-libselinux.patch
# 177453 - for VIRT use proc->vm_size rather then proc->size (workaround)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-top-env-vmsize.patch
# 174619 - workaround for reliable Cpu(s) data in the first loop
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.7-top-env-cpuloop.patch
# 185299 - cpu steal time support
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-cpusteal.patch.gz | patch -p1 -E --backup --verbose
# 134516 - ps ignores /proc/#/cmdline if contents 2047 bytes
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-longcmd.patch.gz | patch -p1 -E --backup --verbose
# 189349 - 32bit vmstat on 64bit kernel
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-pgpg.patch.gz | patch -p1 -E --backup --verbose
# 212637 - sysctl using deprecated syscall
# 228870 - process `sysctl' is using deprecated sysctl ...
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-sysctl-ignore.patch.gz | patch -p1 -E --backup --verbose
# 140975 - top corrupts screen when sorting on first column
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-sorthigh.patch.gz | patch -p1 -E --backup --verbose
# 234546 - 'w' doesn't give correct information about what's being run.
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-w-best.patch.gz | patch -p1 -E --backup --verbose
# 183029 - watch ignores unicode characters
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.7-watch-unicode.patch
# 222251 - STIME can jitter by one second
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-stime.patch.gz | patch -p1 -E --backup --verbose
#208217 - command "ps jax --sort=uid,-ppid,+pid" fails
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-plussort.patch.gz | patch -p1 -E --backup --verbose
#244152 - ps truncates eip and esp to 32-bit values on 64-bit systems
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-eip64.patch.gz | patch -p1 -E --backup --verbose
#244960 - ps manpage formatted incorrectly
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-psman.patch.gz | patch -p1 -E --backup --verbose
#255441 - ldopen libselinux.so.1 instead of libselinux.so
#zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-libselinux.patch.gz | patch -p1 -E --backup --verbose
#185994 - error when using "Single Cpu = Off" option
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-cpu0.patch.gz | patch -p1 -E --backup --verbose
#354001 - CPU value in top is reported as an integer
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-cpuint.patch
#296471 - update top man page.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-manpage.patch.gz | patch -p1 -E --backup --verbose
#440694 - strange text after selecting few field
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-clrscr.patch.gz | patch -p1 -E --backup --verbose
#435453 - errors with man -t formatting of ps man page
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-man-fmt.patch.gz | patch -p1 -E --backup --verbose
#472783 - 'vmstat -p <partition name>', 
# the detailed statistics of the partition name is not output.
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-partstats-long.patch.gz | patch -p1 -E --backup --verbose
# Fix vmstat header to be 80 chars not 81
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-header.patch.gz | patch -p1 -E --backup --verbose
# rhel bug #475963: slabtop -o should display the info once
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-slabtop-once.patch.gz | patch -p1 -E --backup --verbose
#476134 - added timestamp to vmstat with new option -t
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-timestamp.patch.gz | patch -p1 -E --backup --verbose
#manual page updated to document the -t functionality
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-timestamp-manpage.patch.gz | patch -p1 -E --backup --verbose
#added cgroup display to ps
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.7-ps-cgroup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-ps-cgroup-suppress-root-group.patch
# 'requested writes' display in partition statistics
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-partstats-reqwrites.patch.gz | patch -p1 -E --backup --verbose
# '-l' option of 'free' documented
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-free-hlmem.patch.gz | patch -p1 -E --backup --verbose
# bug in showing threads fixed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-threads.patch
# enable core file generation (don't trap it)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-enable-core.patch
#548711 -  [abrt] crash in procps-3.2.8-3.fc12
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-setlocale.patch
# debian bug #505571 pmap -x should show more information
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-pmap-smaps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-vmstat-getopt.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8+gmake-3.82.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-linux-ver-init.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/procps-3.2.8-forest-prefix.patch

set +e +o pipefail
