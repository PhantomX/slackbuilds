
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# do not store history in /tmp
# http://bugzilla.redhat.com/990197
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.14.1-history_cache_instead_of_tmp.patch

set +e +o pipefail
