
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    patch -p1 --verbose -i ${SB_PATCHDIR}/updates/${file} || exit 1
  done
fi

# Revert this
filterdiff -p1 -x CHANGELOG ${DOWNDIR}/autofs-5.0.5-add-external-bind-method.patch \
 | patch -p1 -R
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.5-fix-building-without-sasl.patch

set +e +o pipefail
