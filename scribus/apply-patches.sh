
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.5-system-hyphen.patch.gz | patch -p1 -E --backup --verbose
# fix version variable for buildsystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-version.patch

set +e +o pipefail
