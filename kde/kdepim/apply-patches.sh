
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# revert http://websvn.kde.org/?view=revision&revision=1072331
#zcat ${SB_PATCHDIR}/${NAME}-4.4.0-install-headers.patch.gz | patch -p0 -E --backup --verbose

# http://bugzilla.redhat.com/show_bug.cgi?id=496988
#zcat ${SB_PATCHDIR}/${NAME}-4.3.1-kmail-saveAttachments.patch.gz | patch -p0 -E --backup --verbose

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_4.4.93_newresultpage_mem_fn-fixbuild.patch

# Trunk Patches

# upstream patches

set +e +o pipefail
