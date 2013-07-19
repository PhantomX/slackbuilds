
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.8-werror.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.10-efi-boot.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.9-buffer_overflow.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-manpagefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-rootstat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-usalinst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-readsegfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-format.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-handler.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-dvdman.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-paranoiacdda.patch
patch -p1 -E --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-utf8.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-cmakewarn.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-memset.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.11-paranoiacdio.patch

set +e +o pipefail
