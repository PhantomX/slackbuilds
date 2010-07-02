
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# shrink default initial db size a bit (approx 140mb->28mb)
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-mysql_conf.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# backport from trunk/
#
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.1-mysql_update_backport.patch

set +e +o pipefail
