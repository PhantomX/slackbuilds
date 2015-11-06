
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    patch -p1 --verbose -i ${SB_PATCHDIR}/updates/${file}
  done
fi

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.1.1-fix-fix-gcc5-complaints.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.1.1-update-libtirpc-workaround-for-new-soname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.1.1-revert-fix-libtirpc-name-clash.patch

set +e +o pipefail
