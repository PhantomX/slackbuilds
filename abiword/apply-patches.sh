
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose

# abiword-plugins
#zcat ${SB_PATCHDIR}/${NAME}-plugins-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose

# abiword documentation
( cd ${SRCDIR4}
  zcat ${SB_PATCHDIR}/${NAME}-2.6.0-windowshelppaths.patch.gz | patch -p1 -E --backup --verbose
)

set +e +o pipefail
