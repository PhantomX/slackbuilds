
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.1-sd-service-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.8.0-immutable-json-props.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.12.0-gnutls-detection.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
