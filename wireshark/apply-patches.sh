
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.10.0-enable_lua.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libtool-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.10.0-group-msg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.0-soname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.x-flow-graph-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.x-pod2man-encoding.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
