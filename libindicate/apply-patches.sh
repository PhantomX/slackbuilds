
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# To hell with mono
patch -p1 -E --backup -z .killmono --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.1-no-mono.patch
rm -rf bindings/mono

set +e +o pipefail
