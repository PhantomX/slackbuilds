  
SB_PATCHDIR=${CWD}/patches

# don't strip
zcat ${SB_PATCHDIR}/sudo-1.6.7p5-strip.patch.gz | patch -p1 -E --backup --verbose || exit 1
# use specific PAM session for sudo -i (#198755)
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-login.patch.gz | patch -p1 -E --backup --verbose || exit 1
# configure.in fix
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-envdebug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sudo-1.7.1-libtool.patch.gz | patch -p1 -E --backup --verbose || exit 1
# getgrouplist() to determine group membership (#235915)
zcat ${SB_PATCHDIR}/sudo-1.7.2p3-getgrouplist.patch.gz | patch -p1 -E --backup -z .getgrouplist --verbose || exit 1
# audit support improvement
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-audit.patch.gz | patch -p1 -E --backup --verbose || exit 1
# segfault when #include directive is used in cycles (#561336)
zcat ${SB_PATCHDIR}/sudo-1.7.2p2-loopsegv3.patch.gz | patch -p1 -E --backup --verbose || exit 1
# audit related Makefile.in and configure.in corrections
zcat ${SB_PATCHDIR}/sudo-1.7.2p2-libaudit.patch.gz | patch -p1 -E --backup --verbose || exit 1
