
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.44-getCMD.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.44-inetd.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.47-chklastlog.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.49-nophpcheck.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.49-chkproc-psver.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.49-chkutmp-outofbounds.patch

set +e +o pipefail
