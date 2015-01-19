
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bitbucket.org/brandon/backports.ssl_match_hostname/pull-request/1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-backports-ssl_match_hostname-namespace.patch

set +e +o pipefail
