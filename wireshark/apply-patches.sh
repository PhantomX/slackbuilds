
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-nfsv4-opts.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.99.7-path.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.0.5-nfs41-backchnl-decode.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.4-filter_null.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.4-enable_lua.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.4-disable_warning_dialog.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.6-nfs40-backchnl-decode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.6-smb-find-full-dir-info.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libtool-pie.patch

set +e +o pipefail
