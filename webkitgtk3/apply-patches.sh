
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.11.2-Double2Ints.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_150963.diff

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
