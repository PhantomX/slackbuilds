
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/hddtemp-db.patch.gz | patch -p0 -E --backup --verbose
# http://savannah.nongnu.org/bugs/index.php?28896
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hddtemp-0.3-beta15-reg-eip.patch

set +e +o pipefail
