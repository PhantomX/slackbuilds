
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-norpath.patch.gz | patch -p1 -E --backup --verbose  
zcat ${SB_PATCHDIR}/${NAME}-perl.patch.gz | patch -p1 -E --backup --verbose  
if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-0.23-ruby1.9.patch.gz | patch -p0 -E --backup --verbose  
fi
set +e +o pipefail
