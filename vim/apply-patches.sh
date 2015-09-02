
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SYNUP}" = "YES" ] && [ ! -r ${CWD}/vim-runtime-syntax-${SYNUPVER}.patch.gz ] ;then
  rm -rf runtime/syntax.orig
  cp -a runtime/syntax runtime/syntax.orig
  echo "Fetching vim syntax updates from ftp.nluug.nl..."
  rsync -avzcP ftp.nluug.nl::Vim/runtime/syntax/ runtime/syntax/
  mkdir -p ${SB_PATCHDIR}/updates
  diff -u -r --new-file runtime/syntax.orig runtime/syntax | gzip -9c \
    > ${CWD}/vim-runtime-syntax-${SYNUPVER}.patch.gz || :
  rm -rf runtime/syntax
  mv runtime/syntax.orig runtime/syntax
fi

zcat ${SB_PATCHDIR}/vim-7.0-fixkeys.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/vim-6.2-specsyntax.patch.gz | patch -p1 --verbose
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.4-crv.patch
if [ "${SB_HUNSPELL}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/vim-7.0-hunspell.patch.gz | patch -p1 --verbose
fi

sed -i \
  -e '/nl \\/d' \
  -e '/nl.mo \\/d' \
  -e '/nl.ck \\/d' \
  src/po/Makefile || exit 1

if [ "${SB_SYNUP}" = "YES" ] ;then
  zcat ${CWD}/vim-runtime-syntax-${SYNUPVER}.patch.gz | patch -p0 --verbose
fi

patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.4-syntax.patch
zcat ${SB_PATCHDIR}/vim-7.1-nowarnings.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/vim-7.0-rclocation.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/vim-6.4-checkhl.patch.gz | patch -p1 --verbose
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.3-fstabsyntax.patch
zcat ${SB_PATCHDIR}/vim-7.0-warning.patch.gz | patch -p1 --verbose
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.4-syncolor.patch
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.0-specedit.patch
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim72-rh514717.patch
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.4-licensemacro-1151450.patch
patch -p1 -E --verbose -i ${SB_PATCHDIR}/vim-7.4-ssh-keywords.patch

patch -p0 -E --verbose -i ${SB_PATCHDIR}/vim-vimrc.patch

set +e +o pipefail
