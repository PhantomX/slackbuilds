
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Convert InstallPrinterDriver requests to lower-case.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lowercase-mfg-mdl.patch

set +e +o pipefail
