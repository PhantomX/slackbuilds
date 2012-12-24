
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.0-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.0-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.0-kwallet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.2-ruby19.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.4-kwallet2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.4-sqlitever.patch

set +e +o pipefail
