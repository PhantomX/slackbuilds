
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

[ "${SB_RTC}" = "YES" ] && patch -p0 -E --backup -z .rtc --verbose -i ${SB_PATCHDIR}/${NAME}-enable-rtc.patch

set +e +o pipefail
