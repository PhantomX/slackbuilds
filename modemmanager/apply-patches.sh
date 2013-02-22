
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rh862341-1-UCS2-conversions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rh862341-2-parse_operator.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rh861620-blacklist-arduino-devices.patch

set +e +o pipefail
