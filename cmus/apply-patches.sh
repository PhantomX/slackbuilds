
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Mageia
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmus-v2.4.3-ffmpeg2.0.patch
## Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmus-2.5.0-cdio-make-it-work-with-libcdio-0.90.patch

set +e +o pipefail
