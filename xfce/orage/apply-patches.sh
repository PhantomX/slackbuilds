
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6237
patch -p1 --verbose -i ${SB_PATCHDIR}/orage-4.6.1-dsofix.patch

set +e +o pipefail
