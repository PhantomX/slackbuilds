
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# don't strip
zcat ${SB_PATCHDIR}/sudo-1.6.7p5-strip.patch.gz | patch -p1 -E --backup --verbose
# use specific PAM session for sudo -i (#198755)
#zcat ${SB_PATCHDIR}/sudo-1.7.2p1-login.patch.gz | patch -p1 -E --backup --verbose
# configure.in fix
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-envdebug.patch.gz | patch -p1 -E --backup --verbose
# getgrouplist() to determine group membership (#235915)
patch -p1 -E --backup -z .getgrouplist --verbose -i ${SB_PATCHDIR}/sudo-1.7.3-getgrouplist.patch 
# audit support improvement
#patch -p1 -E --backup -z .audit --verbose -i ${SB_PATCHDIR}/sudo-1.7.2p6-audit.patch

set +e +o pipefail
