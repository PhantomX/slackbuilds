
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6.0-newer-slackware.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-default-permissions.patch.gz | patch -p1 -E --backup --verbose
# Apply fix from ubuntu for CVE 2008 4311
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-cve-2008-4311.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
