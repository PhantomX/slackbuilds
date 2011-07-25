
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose

# bugfixes


# Pulseaudio patches from http://art.ified.ca/downloads
( mkdir patches
  cp ${SB_WPDIR}/*.patch patches/
  SB_WPDIR=patches
  # Patch the patch
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/winepulse-configure.ac-1.3.22-update.patch
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/winepulse-winecfg-1.3.11-update.patch
  patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE}
  patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE2}
  patch -p1 -E --backup --verbose -i ${SB_WPDIR}/${PPASRCARCHIVE3}
  # filterdiff from patchutils package
  #filterdiff -p1 -x "programs/winecfg/*.rc" ${SB_WPDIR}/${PPASRCARCHIVE3} | patch -p1 -E --backup --verbose
)

set +e +o pipefail
