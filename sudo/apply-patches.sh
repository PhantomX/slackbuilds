
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# don't strip
zcat ${SB_PATCHDIR}/sudo-1.6.7p5-strip.patch.gz | patch -p1 -E --backup --verbose
# configure.in fix
zcat ${SB_PATCHDIR}/sudo-1.7.2p1-envdebug.patch.gz | patch -p1 -E --backup --verbose
# add m4/ to paths in aclocal.m4
patch -p1 -E --backup -z .m4path --verbose -i ${SB_PATCHDIR}/sudo-1.7.4p3-m4path.patch
# disable word wrapping if the ouput is piped
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sudo-1.8.3-pipelist.patch

set +e +o pipefail
