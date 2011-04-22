
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-PolkitUnixProcess-Clarify-that-the-real-uid-is-retur.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Make-PolkitUnixProcess-also-record-the-uid-of-the-pr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Use-polkit_unix_process_get_uid-to-get-the-owner-of-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-pkexec-Avoid-TOCTTOU-problems-with-parent-process.patch

set +e +o pipefail
