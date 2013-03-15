
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.beta17-multilib.patch

sed -i \
  -e 's|print Config::|print RbConfig::|g' \
  -e '/RUBY_CFLAGS/s|"archdir|"rubyhdrdir|g' \
  -e 's|sitearchdir|vendorarchdir|g' \
  -e 's|sitelibdir|vendorlibdir|g' \
  configure.ac || exit 1 onfigure.ac || exit 1
zcat ${SB_PATCHDIR}/libcaca-0.99.beta17-ruby1.9.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
