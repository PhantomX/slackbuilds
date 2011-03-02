
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bz532289.patch
# fix ivalid use of local variable in update_lock_destroy_cb()
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.8-destroycb.patch

set +e +o pipefail
