
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
for ignore in 050 ;do
  sed -i -e "/^${ignore}_.*$/d" patches/series
done
for patch in $(<patches/series) ;do
  patch -p1 -E --backup --verbose -i patches/${patch}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
