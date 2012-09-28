
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lftp-4.0.9-date_fmt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lftp-4.3.8-gets.patch

set +e +o pipefail
