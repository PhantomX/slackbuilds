
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.03-mktemp.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup -z .py27 --verbose -i ${SB_PATCHDIR}/nmap-zenmap-python27.patch

set +e +o pipefail
