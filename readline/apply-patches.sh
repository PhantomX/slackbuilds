# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-5.2-shlib.patch.gz | patch -p1 -E --backup --verbose || exit 1

for i in $( seq -w ${PATCHLEVEL} ) ; do
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}${SVER//.}-${i} || exit 1
done

zcat ${SB_PATCHDIR}/${NAME}-5.2-redisplay-sigint.patch.gz | patch -p1 -E --backup --verbose || exit 1
