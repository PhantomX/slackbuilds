
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
for patch in $(<patches/series) ;do
  patch -p1 -E --backup --verbose -i patches/${patch}
done

set +e +o pipefail
