
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .make --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.0-makefile.patch
patch -p0 -E --backup -z .aud --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.0-audacious.patch

set +e +o pipefail
