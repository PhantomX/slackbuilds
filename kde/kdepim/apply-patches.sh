
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# revert http://websvn.kde.org/?view=revision&revision=1072331
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-install-headers.patch.gz | patch -p0 -E --backup --verbose

# http://bugzilla.redhat.com/show_bug.cgi?id=496988
zcat ${SB_PATCHDIR}/${NAME}-4.3.1-kmail-saveAttachments.patch.gz | patch -p0 -E --backup --verbose

# Trunk Patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088322-kmail-do-not-start-akonadi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088359-kontact-do-not-start-akonadi.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088354-kaddressbook-do-not-start-akonadi.patch 

# upstream patches

set +e +o pipefail
