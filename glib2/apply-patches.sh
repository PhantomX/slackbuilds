
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/03_blacklist-directories.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04_homedir_env.patch

set +e +o pipefail
