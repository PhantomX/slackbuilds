
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd.builddefs.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd.conf.diff

set +e +o pipefail
