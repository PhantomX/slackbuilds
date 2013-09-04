
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
## upstreamable patches
# query/use pkg-config libmusicbrainz5 info
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.98-libmusicbrainz5_cflags.patch

set +e +o pipefail
