
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04_homedir_env.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/revert-warn-glib-compile-schemas.patch
# Upstream fixes from 2.36 branch (Borrowed from Arch)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gvariant-fix-annotation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/partially-revert-ce0022933c255313e010b27f977f4ae02aad1e7e.patch

set +e +o pipefail
