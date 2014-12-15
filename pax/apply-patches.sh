
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
#use Linux PATH_MAX (4092) for maximum PATHLENGTH instead of pax default 3072
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pax-3.0-PATHMAX.patch
#fix bug with archiving files of filename length exactly 100 chars
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pax-3.4-abs100.patch
#do not truncate names when extracting
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pax-3.4-rdtruncate.patch
#do not fail with gcc-4.6+
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pax-gcc46.patch
# manpage edits - s/pax/opax/, add cross references
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pax-3.4-manpage.patch

set +e +o pipefail
