
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .show --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-show-akonadi-kcm.patch

# upstream patches
# kde-l10n-4.5.95 (still) contains conflicting translations, omit here (for now)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.94.1-no_translations.patch

set +e +o pipefail
