
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    patch -p1 --verbose -i ${SB_PATCHDIR}/updates/${file} || exit 1
  done
fi

zcat ${SB_PATCHDIR}/autofs-5.0.5-add-sasl-mutex-callbacks.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
