
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/slrn-0.9.9pre108-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/slrn-0.9.9pre108-sendmail.patch

set +e +o pipefail
