
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-norpath.patch.gz | patch -p1 -E --backup --verbose  
zcat ${SB_PATCHDIR}/${NAME}-perl.patch.gz | patch -p1 -E --backup --verbose  
zcat ${SB_PATCHDIR}/${NAME}-0.23-ruby1.9.patch.gz | patch -p0 -E --backup --verbose  

set +e +o pipefail
