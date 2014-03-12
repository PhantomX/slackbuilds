
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/readline-6.2-shlib-slk.patch

### Arch
# patch from upstream mailing list to fix vi mode
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/readline-6.3-vi-last.patch
# patch from upstream mailing list to fix the crash after pressing Delete twice
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/readline-6.3-dispatch-multikey.patch

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/readline${SVER//.}-${i} || exit 1
  done
fi

set +e +o pipefail
