
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .slk --verbose -i ${SB_PATCHDIR}/${NAME}.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/63_init_keep_utf8_ttyflag.patch
# Unlink /.autofsck on shutdown -f
zcat ${SB_PATCHDIR}/${NAME}-2.86-autofsck.patch.gz | patch -p1 -E --backup --verbose
# Invoke single-user shell as a login shell (#105653)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.86-loginshell.patch
# Fix single user mode (#176348)
zcat ${SB_PATCHDIR}/${NAME}-2.86-single.patch.gz | patch -p1 -E --backup --verbose
# Be less verbose when booted with 'quiet'
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.88-quiet.patch
# Change accepted ipv6 addresses (#573346)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.88-ipv6.patch
# Add option to pidof to exclude similar processes to omitted processes (#632321)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.88-omit.patch
# Fix counting MAXLINES in wall
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.88-wall-maxlines.patch

set +e +o pipefail
