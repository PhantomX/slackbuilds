
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.beta17-multilib.patch

if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  sed -i -e '/RUBY_CFLAGS/s|archdir|rubyhdrdir|g' configure.ac || exit 1
  zcat ${SB_PATCHDIR}/libcaca-0.99.beta17-ruby1.9.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
