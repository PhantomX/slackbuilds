  
SB_PATCHDIR=${CWD}/patches

( cd MIM || exit 1
  zcat ${SB_PATCHDIR}/number_pad_itrans-222634.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/si-wijesekera-keymap-rename_key-summary.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/bn-itrans-t-182227.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/kn-itrans-ZWNJ-221965.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/kn-itrans_key-summary_228806.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ml-itrans-keysummary-435260.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1
