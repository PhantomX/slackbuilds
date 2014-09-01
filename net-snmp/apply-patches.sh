
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7.2-pie.patch
zcat ${SB_PATCHDIR}/${NAME}-5.5-dir-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-apsl-copying.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7-perl-linking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6-test-debug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7.2-systemd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7.2-python-ipaddress-size.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7.2-create-user-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7.2-btrfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.7-agentx-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-agentx-disconnect-crash.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
