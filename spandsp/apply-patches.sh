
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# touch configure only
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/spandsp-0.0.6-brackets.patch

set +e +o pipefail
