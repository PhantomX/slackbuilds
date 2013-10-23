
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# gksu-polkit do not have parameters
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.0-gksu-parameters.patch

set +e +o pipefail
