
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=717479
# https://bugzilla.redhat.com/show_bug.cgi?id=710055
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hddtemp-0.3-beta15-autodetect-717479.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Allow-binding-to-a-listen-address-that-doesn-t-exist.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Try-attribute-190-if-194-doesn-t-exist.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-model-length.patch

set +e +o pipefail
