
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .droid --verbose -i ${SB_PATCHDIR}/${NAME}-2.67-droid.patch
sed -i.font -e '/fontpath/s|/fonts/|\0TTF/|g' source/blender/blenfont/intern/blf_translation.c

# https://developer.blender.org/T42183
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.72-size_t.patch

set +e +o pipefail
