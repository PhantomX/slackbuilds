
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/12_fix_chess_engine.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

set +e +o pipefail
