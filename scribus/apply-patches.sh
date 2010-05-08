
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.3.5-system-hyphen.patch.gz | patch -p1 -E --backup --verbose
# fix version variable for buildsystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.6-version.patch
# fix QString initialization in Qt 4.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.6-qstring.patch
# fix linking with --no-add-needed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.6-linker.patch
# fix build with podofo 0.8.0
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.6-podofo-0.8.0.patch

set +e +o pipefail
