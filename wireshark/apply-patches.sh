
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.4-enable_lua.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libtool-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.1-group-msg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.0-soname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.2-nfsv41-addstatus.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gnome3-msgbox.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-import-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-netlogon-aes.patch
 
set +e +o pipefail
