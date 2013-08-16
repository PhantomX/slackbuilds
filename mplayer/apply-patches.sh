
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0pre8-config.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-ivtv.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-mkv.patch

set +e +o pipefail
