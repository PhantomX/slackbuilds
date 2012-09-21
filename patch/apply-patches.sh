
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/patch.281537bcd92515ae3b9f154acd579ce97260f99b.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}//patch.99f2638763845d8173a0c9f9209ac2b4be947165.diff

set +e +o pipefail
