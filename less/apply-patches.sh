
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/less.sysconfdir.patch.gz | patch -p1 --verbose
patch -p1 -E --backup -z .Foption --verbose -i ${SB_PATCHDIR}/less-438-Foption.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-418-fsync.patch

set +e +o pipefail
