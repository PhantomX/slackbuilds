
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wine-rpath.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose

# http://bugs.winehq.org/show_bug.cgi?id=16328
patch -p1 -E --backup -z .intz --verbose -i ${SB_PATCHDIR}/wine-1.1.41-wineintz.patch

# Pulseaudio patches from http://art.ified.ca/downloads
patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE}
patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE2}
patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE3}
sed -i -e '/@DEPENDENCIES@/d' dlls/winepulse.drv/Makefile.in

set +e +o pipefail
