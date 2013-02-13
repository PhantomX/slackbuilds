
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-disable-the-cache-for-the-SQlite-backend.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Don-t-try-to-start-akonadiserver-if-mysqld-is-not-in.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Ignore-the-custom-settings-in-.my.cnf.patch

set +e +o pipefail
