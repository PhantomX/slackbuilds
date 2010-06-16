
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/kgtk-0.10.1-kgtk2_wrapper_lib_suffix.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kgtk-0.10.1-qt4_wrapper_lib_suffix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kgtk-0.10.1-glibc-2.10.patch

set +e +o pipefail
