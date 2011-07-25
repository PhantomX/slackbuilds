
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .slk --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-no-cron-redirection.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-rot-size.patch

set +e +o pipefail
