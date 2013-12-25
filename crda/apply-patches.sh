
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Add udev rule to call setregdomain on wireless device add
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/regulatory-rules-setregdomain.patch

set +e +o pipefail
