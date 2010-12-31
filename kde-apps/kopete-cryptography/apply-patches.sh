
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.3.0-kde4.1.3-prevent-chat-session-destroyed.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
