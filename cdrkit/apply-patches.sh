
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.8-werror.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.10-efi-boot.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.9-buffer_overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-manpagefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-rootstat.patch

set +e +o pipefail
