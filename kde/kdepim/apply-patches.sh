
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .install-headers --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.93-install-headers.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_4.4.93_newresultpage_mem_fn-fixbuild.patch

# Trunk Patches

# upstream patches

set +e +o pipefail
