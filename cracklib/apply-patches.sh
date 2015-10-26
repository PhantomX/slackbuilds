
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.9.1-inttypes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.9.0-python-gzdicts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.9.6-packlib-reentrant.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.9.6-simplistic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.9.6-translation-updates.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
