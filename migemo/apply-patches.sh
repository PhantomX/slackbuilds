
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -i '18d' migemo-convert.rb
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.40-bz830559.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ruby-1.9.patch

set +e +o pipefail
