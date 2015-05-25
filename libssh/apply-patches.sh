
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1221310
# https://red.libssh.org/issues/194
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Reintroduce-ssh_forward_listen-Fixes-194.patch

set +e +o pipefail
