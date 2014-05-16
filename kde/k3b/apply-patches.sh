
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.1-sndfile-inc.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-ffmpeg2.patch

## upstreamable patches
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-use_vartmp_instead_of_tmp.patch

## upstream patches

set +e +o pipefail
