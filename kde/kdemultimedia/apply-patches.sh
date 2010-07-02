
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kmix-pulse.patch
# git clone git://colin.guthr.ie/kdemultimedia
# git diff master..remotes/origin/pulse > kmix_pa-<date>.patch
if [ "${SB_PA}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kmix-pulse.patch
fi

set +e +o pipefail
