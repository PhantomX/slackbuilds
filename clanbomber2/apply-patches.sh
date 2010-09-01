
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-gcc43.patch.gz | patch -p0 -E --backup --verbose
# http://bbs.archlinux.org/viewtopic.php?id=52705
zcat ${SB_PATCHDIR}/${NAME}-fusionsound_new_api.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
