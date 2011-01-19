
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# don't strip
zcat ${SB_PATCHDIR}/sudo-1.6.7p5-strip.patch.gz | patch -p1 -E --backup --verbose
# configure.in fix
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-envdebug.patch.gz | patch -p1 -E --backup --verbose
# add m4/ to paths in aclocal.m4
patch -p1 -E --backup -z .m4path --verbose -i ${SB_PATCHDIR}/sudo-1.7.4p3-m4path.patch
# getgrouplist() to determine group membership (#235915)
patch -p1 -E --backup -z .getgrouplist --verbose -i ${SB_PATCHDIR}/sudo-1.7.4p4-getgrouplist-fixed.patch
# reset HOME when using the `-i' option (#635250)
patch -p0 -E --backup -z .sudoi --verbose -i ${SB_PATCHDIR}/sudo-1.7.4p4-sudoi.patch

set +e +o pipefail
