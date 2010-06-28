
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.osafoundation.org/show_bug.cgi?id=2341
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.18-timeouts.patch
# This is only precautionary, it does fix anything - not sent upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.20-gcc_macros.patch
# https://bugzilla.osafoundation.org/show_bug.cgi?id=12855
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.20.1-openssl1.patch
# https://bugzilla.osafoundation.org/show_bug.cgi?id=12935
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.20.2-threads.patch
# https://bugzilla.osafoundation.org/show_bug.cgi?id=12936
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.20.2-testsuite.patch

set +e +o pipefail
