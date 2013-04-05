# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-pgsql.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-logging.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-perl-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multi-sockets.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-var-run-socket.patch

set +e +o pipefail
