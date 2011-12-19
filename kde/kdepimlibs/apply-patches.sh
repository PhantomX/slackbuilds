
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
# kio_imap APPEND omits message size without flags
# https://bugs.kde.org/289084
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.4-kio_imap_append_without_flags.patch
# https://bugs.kde.org/249992
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.3-dovecot_kde249992.patch

set +e +o pipefail
