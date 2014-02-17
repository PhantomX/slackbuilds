
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.10.0-no-pentium-on-i386.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ode-0.11.1-multilib.patch

set +e +o pipefail
