
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/1151558-switch-man-and-root-in-init-systemd-man-db.conf.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
