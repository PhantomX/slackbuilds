
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wine-rpath.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose

# Pulseaudio patches from http://art.ified.ca/downloads
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE}
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE2}
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PPASRCARCHIVE3}

set +e +o pipefail
