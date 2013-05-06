
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.03-help.patch.gz | patch -p1 -E --backup --verbose
sed \
  -e "s#%PREFIX%/share/cows#/usr/share/${NAME}#" \
  -e "s#%BANGPERL%#!/usr/bin/perl#" \
  -i ${NAME}
sed \
  -e "s#%PREFIX%/share/cows#/usr/share/${NAME}#" \
  -e "s#/usr/local/share/cows#/usr/share/${NAME}#" \
  -i ${NAME}.1

mv cows/mech-and-cow cows/mech-and-cow.cow
zcat ${SB_PATCHDIR}/mech-and-cow.patch.gz | patch -p1 --verbose

set +e +o pipefail
