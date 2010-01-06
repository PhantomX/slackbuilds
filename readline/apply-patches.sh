# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/readline-5.2-shlib.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/readline${SVER//.}-${i} || exit 1
  done
fi
