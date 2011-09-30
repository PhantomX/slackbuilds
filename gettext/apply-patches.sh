
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .rpathfix --verbose -i ${SB_PATCHDIR}/gettext-0.18-rpathFix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gettext-readlink-einval.patch

set +e +o pipefail
