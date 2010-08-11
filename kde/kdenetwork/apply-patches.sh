
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream me!  -- Rex :)
zcat ${SB_PATCHDIR}/${NAME}-4.2.98-kdrc-icon.patch.gz | patch -p1 -E --backup --verbose
# rhbz#540433 - KPPP is unable to add DNS entries to /etc/resolv.conf
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-resolv-conf-path.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.2-kopete-searchbar_new_line.patch

## security patches

set +e +o pipefail
