
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.1-printing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.2-kcmprinter_root_privs.patch

## upstream patches

set +e +o pipefail
