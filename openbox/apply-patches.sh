
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.4.7.2-gdm.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.4.9-xdg.patch.gz | patch -p0 -E --backup --verbose 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.4.11-Xau.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.4.7.2-24bit.patch

set +e +o pipefail
