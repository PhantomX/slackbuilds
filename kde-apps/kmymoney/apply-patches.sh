
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r9b6f96a38b8c84cb87bb07165b503acbe5ea81ff_r4da92dfa03209670bddb7801926a25741c0ad6ec.diff

set +e +o pipefail
