
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Convert InstallPrinterDriver requests to lower-case.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lowercase-mfg-mdl.patch
# Fixed traceback in check-driver-ids.py when no drivers are found
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cdi-no-drivers.patch
# Show CMD field in check-device-ids.py.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cdi-cmd.patch
# The canonical name for Kyocera is Kyocera Mita.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kyocera-mita.patch
# check-device-ids.py: Fixed driver-URI to filename mapping.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cdi-filename.patch
# Fixed reconnection error handling in IPPAuthOperation class.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-reconnect-error.patch
# Initialize downloadable_drivers when OpenPrinting query fails.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-downloadable-drivers.patch

set +e +o pipefail
