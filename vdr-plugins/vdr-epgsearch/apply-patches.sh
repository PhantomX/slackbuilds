
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|__VARDIR__|${vdr_vardir}|g" ${SB_PATCHDIR}/${NAME}-1.0.1.beta2-fedora.patch \
  | patch -p1 -E --fuzz=0 --backup -z .orig--verbose

set +e +o pipefail
