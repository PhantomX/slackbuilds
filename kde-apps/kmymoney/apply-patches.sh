
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Fix-the-investment-accounts-handling-in-the-institut.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Only-load-the-child-accounts-if-there-are-any-otherw.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Make-Use-system-color-the-default-behavior.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Use-the-Higlight-background-color-for-warnings-since.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-Use-the-proper-color-group-depending-on-the-focus-st.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Save-the-header-state-in-the-investment-view-s-lists.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Fix-a-crash-when-cancelling-the-OFX-update-dialog-wh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-Make-sure-that-all-transactions-have-a-valid-post-da.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-Fix-a-possible-crash-while-mapping-an-OFX-account.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-cmake-libkgpgfile-needs-the-kdepimlibs-include-dirs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-Added-definition-for-new-Azerbaijani-Manat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-Enable-factor-widget-when-online-source-is-selected.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0015-Hide-remove-sensitive-information-from-anon-file.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0016-When-KWallet-is-opened-synchronously-do-it-in-a-safe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0019-Fix-the-category-selection-actions-in-the-find-trans.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0020-Fix-build-with-GMP-5.1.0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0022-BUG-316042-KMyMoney-hangs-when-editing-transaction-i.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r9b6f96a38b8c84cb87bb07165b503acbe5ea81ff_r4da92dfa03209670bddb7801926a25741c0ad6ec.diff

set +e +o pipefail
