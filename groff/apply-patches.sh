
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-info-missing-x11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-makefile-typo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-manpages-typos.patch
patch -p1 -E --backup -z .grofferdir-auto --verbose -i ${SB_PATCHDIR}/groff-grofferdir-auto.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-grotty-wc-no-sgr.patch

set +e +o pipefail
