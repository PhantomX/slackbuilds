
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# shrink default initial db size a bit (approx 140mb->28mb)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mysql_conf.patch

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-server-1.4.0-remove-sqlite-version-assert.patch

set +e +o pipefail
