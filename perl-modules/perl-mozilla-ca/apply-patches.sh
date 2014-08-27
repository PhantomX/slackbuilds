
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

if [ -e /etc/pki/tls/certs/ca-bundle.crt ] ;then
  patch -p1 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/Mozilla-CA-20130114-Redirect-to-ca-certificates-bundle.patch
fi

set +e +o pipefail
