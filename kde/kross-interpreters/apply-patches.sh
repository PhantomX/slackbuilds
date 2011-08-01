
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ruby
  patch -p5 --verbose --backup -z .len_ptr -i ${SB_PATCHDIR}/kdebindings-len-ptr-rfloat.diff
  patch -p5 --verbose --backup -z .rbenv -i ${SB_PATCHDIR}/kdebindings-ruby-env.h.diff
  patch -p5 --verbose --backup -z .rbconfig -i ${SB_PATCHDIR}/kdebindings-rubyconfig.h.diff
)

set +e +o pipefail
