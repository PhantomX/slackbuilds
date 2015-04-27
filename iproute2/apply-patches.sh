
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-docs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-cbq-example.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-route-cloned.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-lnstat-stdout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.19.0-lnstat-interval.patch
# Rejected by upstream <http://thread.gmane.org/gmane.linux.network/284101>
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-tc-ok.patch

set +e +o pipefail
