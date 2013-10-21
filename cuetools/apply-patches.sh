
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/0003-cuetag.sh-Correct-typo-in-error-output.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_build_with_automake-1.12.diff

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
