
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-lp-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-r104-fixes.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/restorecon.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-nxpath-616993.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-nxdialog-627010.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-optflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-nxipp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-nxagent-version-827176.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-authkeys2-830838.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.3-ncat-891109-903186.patch

set +e +o pipefail
