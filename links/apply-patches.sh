
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Patches from Gentoo
zcat ${SB_PATCHDIR}/configure-LANG.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1pre33-utf8.patch.gz | patch -p1 -E --backup --verbose || exit 1
( cd intl
  ./gen-intl
  ./synclang
)

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/links-2.2-nss.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/links-2.2-ssl-verify.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/links-2.2-google.patch

set +e +o pipefail
