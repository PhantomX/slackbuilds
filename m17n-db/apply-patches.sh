
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd MIM
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/m17n-db-1.6.5-bn-itrans-bug182227.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/m17n-db-1.6.5-kn-itrans_key-summary_bug228806.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/m17n-db-1.6.5-kn-inscript-ZWNJ-bug440007.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/m17n-db-1.6.5-number_pad_itrans-222634.patch
)

set +e +o pipefail
