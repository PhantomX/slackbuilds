
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .celt --verbose -i ${SB_PATCHDIR}/gst-plugins-bad-0.10.21-celt011.patch

set +e +o pipefail
