  
SB_PATCHDIR=${CWD}/patches

# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose || exit 1

#zcat ${SB_PATCHDIR}/${NAME}-3.2.7-selinux.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1.15-misc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.3-FAQ.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-selinux-workaround.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.3-noproc.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.2.3-pseudo.patch
zcat ${SB_PATCHDIR}/${NAME}-3.2.4-0x9b.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 157725 - sysctl -A returns an error
zcat ${SB_PATCHDIR}/${NAME}-3.2.5-sysctl-writeonly.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 161449 - "top" ignores user and system toprc
zcat ${SB_PATCHDIR}/${NAME}-3.2.5-top-rc.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 161303 - 'top' failed when remove cpus
# 186017 - Top "Cpu0" line never updates on single processor machine
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-remcpu.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Selinux
#zcat ${SB_PATCHDIR}/${NAME}-3.2.6-libselinux.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 177453 - for VIRT use proc->vm_size rather then proc->size (workaround)
zcat ${SB_PATCHDIR}/${NAME}-3.2.6-top-env-vmsize.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 174619 - workaround for reliable Cpu(s) data in the first loop
zcat ${SB_PATCHDIR}/${NAME}-3.2.6-top-env-cpuloop.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 185299 - cpu steal time support
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-cpusteal.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 134516 - ps ignores /proc/#/cmdline if contents 2047 bytes
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-longcmd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 189349 - 32bit vmstat on 64bit kernel
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-pgpg.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 212637 - sysctl using deprecated syscall
# 228870 - process `sysctl' is using deprecated sysctl ...
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-sysctl-ignore.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 140975 - top corrupts screen when sorting on first column
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-sorthigh.path.gz | patch -p1 -E --backup --verbose || exit 1
# 234546 - 'w' doesn't give correct information about what's being run.
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-w-best.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 183029 - watch ignores unicode characters
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-watch-unicode.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 222251 - STIME can jitter by one second
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-stime.patch.gz | patch -p1 -E --backup --verbose || exit 1
#208217 - command "ps jax --sort=uid,-ppid,+pid" fails
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-plussort.patch.gz | patch -p1 -E --backup --verbose || exit 1
#244152 - ps truncates eip and esp to 32-bit values on 64-bit systems
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-eip64.patch.gz | patch -p1 -E --backup --verbose || exit 1
#244960 - ps manpage formatted incorrectly
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-psman.patch.gz | patch -p1 -E --backup --verbose || exit 1
#255441 - ldopen libselinux.so.1 instead of libselinux.so
#zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-libselinux.patch.gz | patch -p1 -E --backup --verbose || exit 1
#185994 - error when using "Single Cpu = Off" option
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-cpu0.patch.gz | patch -p1 -E --backup --verbose || exit 1
#354001 - CPU value in top is reported as an integer
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-cpuint.patch
#296471 - update top man page.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-manpage.patch.gz | patch -p1 -E --backup --verbose || exit 1
#440694 - strange text after selecting few field
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-top-clrscr.patch.gz | patch -p1 -E --backup --verbose || exit 1
#435453 - errors with man -t formatting of ps man page
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-man-fmt.patch.gz | patch -p1 -E --backup --verbose || exit 1
#472783 - 'vmstat -p <partition name>', 
# the detailed statistics of the partition name is not output.
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-partstats-long.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix vmstat header to be 80 chars not 81
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-header.patch.gz | patch -p1 -E --backup --verbose || exit 1
# rhel bug #475963: slabtop -o should display the info once
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-slabtop-once.patch.gz | patch -p1 -E --backup --verbose || exit 1
#476134 - added timestamp to vmstat with new option -t
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-timestamp.patch.gz | patch -p1 -E --backup --verbose || exit 1
#manual page updated to document the -t functionality
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-timestamp-manpage.patch.gz | patch -p1 -E --backup --verbose || exit 1
#added cgroup display to ps
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-ps-cgroup.patch.gz | patch -p1 -E --backup --verbose || exit 1
# 'requested writes' display in partition statistics
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-vmstat-partstats-reqwrites.patch.gz | patch -p1 -E --backup --verbose || exit 1
# '-l' option of 'free' documented
zcat ${SB_PATCHDIR}/${NAME}-3.2.7-free-hlmem.patch.gz | patch -p1 -E --backup --verbose || exit 1
