
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.9.1-config.patch
# porttime is part of libportmidi.so, there's no libporttime in Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pygame-1.9.1-porttime.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pygame-1.9.1-no-test-install.patch
# patch backported from upstream repository, V4L has been remove in linux-2.6.38
# http://svn.seul.org/viewcvs/viewvc.cgi?view=rev&root=PyGame&revision=3077
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pygame-remove-v4l.patch

set +e +o pipefail
