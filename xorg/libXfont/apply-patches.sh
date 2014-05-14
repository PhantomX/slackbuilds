
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
# Arch FS#40044 - merged for branch 1.5
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-for-fontsproto213.patch
# fix CVE-2014-209 CVE-2014-210 CVE-2014-211 - merged upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/CVE-2014-209-210-211.patch
  
set +e +o pipefail
