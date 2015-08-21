
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
for patch in patch/tc.file/*.patch ;do
  patch -p0 -E --backup --verbose  -i ${patch} || exit 1
done

for patch in $(seq -w 001 011) ;do
  patch -p1 -E --backup --verbose -i patch/${patch}_*.patch || exit 1
done

for patch in 012 013 ;do
  patch -p0 -E --backup --verbose  -i patch/${patch}_*.patch || exit 1
done

set +e +o pipefail
