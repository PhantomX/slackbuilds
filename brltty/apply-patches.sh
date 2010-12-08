
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-cppflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.10-api-socket-dir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-autoconf-quote.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2-S_ISCHR.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-parallel.patch

set +e +o pipefail
