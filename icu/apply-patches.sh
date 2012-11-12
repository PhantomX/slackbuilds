
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -R -E --backup --verbose -i ${SB_PATCHDIR}/icu.8198.revert.icu5431.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.8800.freeserif.crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.7601.Indic-ccmp.patch
patch -p0 -E --backup --verbose -d source -i ${SB_PATCHDIR}/icu-4.8.1.1-fix_ltr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu-50.1-no-c++11.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
