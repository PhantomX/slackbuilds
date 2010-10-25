
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-4.4.4-64bit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-4.5.2-QT_SHARED.patch.gz | patch -p1 -E --backup --verbose
# fix implicit linking when checking for QtAssistant, QtHelp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.7.2-fix-implicit-linking.patch

set +e +o pipefail
