
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -s -p1 -b --suffix .dv1 -fuzz=0 -i alt/dv1.diff
patch -s -p1 -b --suffix .ij1 -fuzz=0 -i alt/ij1.diff

set +e +o pipefail
