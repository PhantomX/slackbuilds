
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ctags-5.7-destdir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.7-segment-fault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.8-css.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.8-ocaml-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.8-cssparse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.8-memmove.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-5.8-format-security.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ctags-CVE-2014-7204.patch

set +e +o pipefail
