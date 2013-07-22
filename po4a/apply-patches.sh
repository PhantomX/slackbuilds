
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Remove-defined-anachronism.patch
# Patch sent upstream on 2013-04-17.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/po4a-0.44-use-tempfile-correctly.patch

set +e +o pipefail
