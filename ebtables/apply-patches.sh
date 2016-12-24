
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-norootinst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.9-lsb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-linkfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.0-audit.patch
# Upstream commit 5e126db0f
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-add-RARP-and-update-iana-url.patch
# Move lockfile to /run/ebtables.lock
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-lockdirfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.10-noflush.patch

set +e +o pipefail
