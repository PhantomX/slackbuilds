
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches

# https://bugs.kde.org/249992
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.3-dovecot_kde249992.patch

set +e +o pipefail
