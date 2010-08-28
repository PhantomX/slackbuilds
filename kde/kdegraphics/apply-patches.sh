
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# CVE-2010-2575, Okular PDB Processing Memory Corruption Vulnerability 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-okular-cve-2010-2575.patch

set +e +o pipefail
