
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.3.1-usexwd.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.3.1-slackware.patch.gz | patch -p0 -E --backup --verbose
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/slim-1.3.6-fix-libslim-libraries.patch

set +e +o pipefail
