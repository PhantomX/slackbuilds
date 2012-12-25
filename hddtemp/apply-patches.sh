
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/hddtemp-db.patch.gz | patch -p0 -E --backup --verbose
# https://bugzilla.redhat.com/show_bug.cgi?id=717479
# https://bugzilla.redhat.com/show_bug.cgi?id=710055
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hddtemp-0.3-beta15-autodetect-717479.patch

set +e +o pipefail
