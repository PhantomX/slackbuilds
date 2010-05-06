
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.4.0-show-akonadi-kcm.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdepim-4.4.1-t1108280-kres-fix-instance-creation.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdepim-4.4.1-t1108431-kres-do-not-start-akonadi.patch

set +e +o pipefail
