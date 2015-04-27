
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-menu.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-O6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-postscriptdriver.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-yyin.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
