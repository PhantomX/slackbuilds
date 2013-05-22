
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches from Slackware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.diff
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.2-crypt.diff

set +e +o pipefail
