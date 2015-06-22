
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/kde3-acinclude.patch.gz | patch -p1 -E --backup --verbose
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kde3-automake-add-missing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kde-3.5.10-kde3-standarddirs.patch
zcat ${SB_PATCHDIR}/${NAME}-0.8.1-cast.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.8.1-comment.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.8.1-openssl.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
