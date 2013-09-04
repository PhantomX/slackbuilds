
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-am-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2012-4447.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2012-4564.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-printdir-width.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-jpeg-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2013-1960.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2013-1961.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-manpage-update.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2013-4231.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2013-4232.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2013-4244.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
