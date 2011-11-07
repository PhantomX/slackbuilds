
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup -z .prelink --verbose -i ${SB_PATCHDIR}/nss-softokn-3.12.4-prelink.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/renegotiate-transitional.patch
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nsspem-642433.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Bug-695011-PEM-logging.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-539183.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-646045.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-libnsspem-rhbz-734760.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nsspem-init-inform-not-thread-safe.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-ckbi-1.88.rtm.patch
# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
