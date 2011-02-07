
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# bad hack
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.4-ldap-x86_64-hack.patch

# RH bug #176400
zcat ${SB_PATCHDIR}/${NAME}-2.9.1-im-context-reset.patch.gz | patch -p1 -E --backup --verbose
# RH bug #589555
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30.1-help-contents.patch
# Fix build with gtk+ 2.24.0
patch -p1 -E --backup -z .workaround --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.2-workaround.patch

set +e +o pipefail
