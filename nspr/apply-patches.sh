
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nspr-config-pc.patch
zcat ${SB_PATCHDIR}/nspr-bug-487844.patch.gz | patch -p2 -E --backup --verbose -d nspr
zcat ${SB_PATCHDIR}/nspr-4.6.1-lang.patch.gz | patch -p2 -E --backup --verbose -d nspr
zcat ${SB_PATCHDIR}/nspr-4.7.0-prtime.patch.gz | patch -p2 -E --backup --verbose -d nspr

set +e +o pipefail
