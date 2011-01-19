
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/psi-0.12-qca.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/psi-0.14-configureroomcrash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/psi-0.14-affiliationlistconfigmuc.patch

set +e +o pipefail
