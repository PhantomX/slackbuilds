
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/groff-1.20.1-groffer-datadir.patch.gz | patch -p0 --backup -z .groffer --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-info-missing-x11.patch

set +e +o pipefail
