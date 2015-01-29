
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-strmov.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-install-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-s390-tsc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-logrotate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-file-contents.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-dh1024.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-scripts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-install-db-sharedir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-ownsetup.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-errno.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-string-overflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-covscan-signexpr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-covscan-stroverflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mariadb-ssltest.patch

set +e +o pipefail
