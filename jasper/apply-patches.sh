  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/jasper-1.701.0-GL.patch.gz | patch -p1 -E --backup --verbose || exit 1
# CVE-2007-2721 (bug #240397)
# borrowed from http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=413041;msg=88
zcat ${SB_PATCHDIR}/patch-libjasper-stepsizes-overflow.diff.gz | patch -p1 -E --backup --verbose || exit 1
# borrowed from http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=469786 
zcat ${SB_PATCHDIR}/jpc_dec.c.patch.gz | patch -p1 -E --backup --verbose || exit 1
# OpenBSD hardening patches addressing couple of possible integer overflows
# during the memory allocations
# https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2008-3520
zcat ${SB_PATCHDIR}/jasper-1.900.1-CVE-2008-3520.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2008-3522
zcat ${SB_PATCHDIR}/jasper-1.900.1-CVE-2008-3522.patch.gz | patch -p1 -E --backup --verbose || exit 1
