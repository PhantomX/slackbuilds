
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/PyQt-dso.patch
# fix multilib conflict because of timestamp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.6.2-timestamp-multilib.patch
# use python's --libdir if available instead of assuming exec_prefix/lib
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.8.3-python_libdir.patch

set +e +o pipefail
