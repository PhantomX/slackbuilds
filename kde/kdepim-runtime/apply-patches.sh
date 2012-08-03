
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .show --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-show-akonadi-kcm.patch

# Enable SQLite support in akonadi kcm
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdepim-runtime-4.8.90-akonadi_kcm_sqlite.patch

# upstream patches

set +e +o pipefail
