
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

( cd MIM
  zcat ${SB_PATCHDIR}/number_pad_itrans-222634.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/bn-itrans-t-182227.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/kn-itrans-ZWNJ-221965.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/kn-itrans_key-summary_228806.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/ml-itrans-keysummary-435260.patch.gz | patch -p0 -E --backup --verbose
)

set +e +o pipefail
