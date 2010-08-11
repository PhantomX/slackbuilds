
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-show-akonadi-kcm.patch.gz | patch -p1 -E --backup --verbose

# upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5-beta1-accountwizard_dt.patch

set +e +o pipefail
