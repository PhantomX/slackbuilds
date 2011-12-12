
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://mfoliveira.org/blog/2010/12/24/scrolling-with-the-keyboard/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_with_key_repeats_option.patch

set +e +o pipefail
