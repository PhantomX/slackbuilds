# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.${SVER}.${i} || exit 1
  done
fi
