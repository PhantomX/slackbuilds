
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.1-sip411.patch
# fix crash with current SIP and Python 2.7.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.1-pycapsule.patch

set +e +o pipefail
