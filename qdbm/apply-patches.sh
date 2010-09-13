
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  zcat ${SB_PATCHDIR}/qdbm-1.8.77-ruby1.9.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
