
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.6-libwpd.patch

# abiword-plugins
#zcat ${SB_PATCHDIR}/${NAME}-plugins-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose

# abiword documentation
( cd ${SRCDIR4}
  zcat ${SB_PATCHDIR}/${NAME}-2.6.0-windowshelppaths.patch.gz | patch -p1 -E --backup --verbose
)

set +e +o pipefail
