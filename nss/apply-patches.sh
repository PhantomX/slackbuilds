
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose

# nss-util

# nss-softokn
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/add-relro-linker-option.patch
# Bug: https://bugzilla.mozilla.org/show_bug.cgi?id=562116
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/drbg.patch

# nss
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/renegotiate-transitional.patch
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nsspem-642433.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Bug-695011-PEM-logging.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-539183.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-646045.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-libnsspem-rhbz-734760.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nsspem-init-inform-not-thread-safe.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nsspem-bz754771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/bz784672-protect-against-calls-before-nss_init.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-fix-gcc47-secmodt.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/Bug-800674-Unable-to-contact-LDAP-Server-during-winsync.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/Bug-800682-Qpid-AMQP-daemon-fails-to-load-after-nss-update.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/Bug-800676-nss-workaround-for-freebl-bug-that-causes-openswan-to-drop-connections.patch


# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
