
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.1-sndfile-inc.patch

## upstreamable patches
# wodim(cdrecord) doesnt work for dvds, use growisofs instead
# http://bugzilla.redhat.com/610976
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-use_growisofs_instead_of_wodim.patch

set +e +o pipefail
