
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.3.12-openbsd-owl-tmp.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.5-zforce.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.10-zgreppipe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.13-rsync.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.5-cve-2006-4338.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.13-cve-2006-4337.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.5-cve-2006-4337_len.patch

set +e +o pipefail
