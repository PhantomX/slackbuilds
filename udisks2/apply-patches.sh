
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udisks-2.x-ntfs-3g.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.2-systemd209.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=1074459
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/udisks-2.x.x-CVE-2014-0004.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
