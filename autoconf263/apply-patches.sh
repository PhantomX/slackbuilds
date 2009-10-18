  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-2.62-multilinevars.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-info.patch.gz | patch -p0 -E --backup --verbose || exit 1
sed -i -e "s|${PNAME}\.texi|${NAME}.texi|g;s|${PNAME}\.info|${NAME}.info|g" \
  doc/Makefile.* || exit 1
mv doc/${PNAME}.texi doc/${NAME}.texi || exit 1
rm -f doc/${PNAME}.info
