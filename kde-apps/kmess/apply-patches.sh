
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/giflib-5.0.patch
# Fix crash in ContactListModel (FS#32402)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-crash-in-contactlistmodel.patch
  
set +e +o pipefail
