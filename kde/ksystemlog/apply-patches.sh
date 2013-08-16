
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix ksystemlog to find log files correctly
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdeadmin-4.8.4-syslog.patch

## upstream patches

set +e +o pipefail
