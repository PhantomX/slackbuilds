
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.6-MDNS-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.14.2-pid_file_RHBZ\#1233232.patch
# Chinforinfula uses /usr/sbin for these
patch -p0 -E --backup -z .path --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.8-paths.patch

set +e +o pipefail
