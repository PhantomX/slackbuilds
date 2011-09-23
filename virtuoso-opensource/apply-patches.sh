
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.0-external_iodbc.patch
zcat ${SB_PATCHDIR}/${NAME}-6.1.0-nodemos_buildfix.patch.gz | patch -p1 -E --backup --verbose
# nepomuk encoding error
# https://bugzilla.redhat.com/728857
# http://bugs.kde.org/271664
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.3-encoding.patch

set +e +o pipefail
