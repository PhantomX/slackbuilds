
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.65-syspath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.65-droid.patch
sed -i.font -e '/fontpath/s|/fonts/|\0TTF/|g' source/blender/blenfont/intern/blf_translation.c

set +e +o pipefail
