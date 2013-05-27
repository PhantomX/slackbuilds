
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -R -E --backup --verbose -i ${SB_PATCHDIR}/icu.8198.revert.icu5431.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.7601.Indic-ccmp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icu.9948.mlym-crash.patch
patch -p0 -E --backup --verbose -d source -i ${SB_PATCHDIR}/icu-4.8.1.1-fix_ltr.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
