# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-pgsql.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ac-version.patch
zcat ${SB_PATCHDIR}/${NAME}-logging.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-oom-adj.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-perl-rpath.patch
zcat ${SB_PATCHDIR}/${NAME}-prefer-ncurses.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
