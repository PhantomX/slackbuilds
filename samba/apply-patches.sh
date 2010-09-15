
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# generic patches
zcat ${SB_PATCHDIR}/samba-3.2.0pre1-pipedir.patch.gz | patch -p1 -E --backup --verbose
# The passwd part has been applied, but not the group part
#zcat ${SB_PATCHDIR}/samba-3.2.0pre1-grouppwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/samba-3.2.5-inotify.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-3.5.4-winbind-schannel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-3.5.4-offline_cache.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-3.5.4-winbind_default_domain.patch

set +e +o pipefail
