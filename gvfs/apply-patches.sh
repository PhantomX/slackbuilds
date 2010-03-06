
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-archive-integration.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=591005
zcat ${SB_PATCHDIR}/0001-Add-AFC-backend.patch.gz | patch -p1 -E --backup --verbose

# from upstream
zcat ${SB_PATCHDIR}/gvfs-1.4.1-http-suport-stream-query-info.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gvfs-1.4.1-http-soup-header-parsing.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
