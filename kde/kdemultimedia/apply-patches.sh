
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}-4.3.75-nomplayerthumbs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.75-kscd_doc.patch.gz | patch -p1 -E --backup --verbose
# git clone git://colin.guthr.ie/kdemultimedia
# git diff master..remotes/origin/pulse > kmix_pa-<date>.patch
if [ "${SB_PA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/kmix_pa-20100129.patch.gz | patch -p1 -E --backup --verbose
fi

set +e +o pipefail
