
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11.0-config.patch
patch -p1 -E --backup -z .files --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.0-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-alternatives.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-large-fs.patch

set +e +o pipefail
