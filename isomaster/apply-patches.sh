
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1-optflags.diff.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.3-desktop.diff.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-fortify.patch

set +e +o pipefail
