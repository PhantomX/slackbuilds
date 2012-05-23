
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-blkmapd-remove-pretty_sig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.1-statdpath-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.1-exp-subtree-warn-off.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.3-sm-notify-res_init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.5-idmap-errmsg.patch

set +e +o pipefail
