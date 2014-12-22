
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From fedora without rpm.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.2-slkconfig.patch
# Fix issue with ipcs command and locales
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.2-ipcs-locale.patch
# Fix grep -a issue 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.2-grepopt.patch

set +e +o pipefail
