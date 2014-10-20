
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
# lxsession-db: Don't hang when MIME folders are not available.
# https://sourceforge.net/p/lxde/patches/479/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-lxsession-db.patch

set +e +o pipefail
