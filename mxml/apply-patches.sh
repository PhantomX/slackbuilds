
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Patches from Fedora that are from Debian ;)
#
# fix CVE-2016-4570 and CVE-2016-4571
# From debian. Many thanks.
#
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05_stack_recursion_fix.diff
#
# fix minor version that wasn't incremented for 2.9
#
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04_minor_version.diff
# Fix rpath issues
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01_remove_rpath.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02_link_with_pthread.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/03_link_ldflags.diff

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
