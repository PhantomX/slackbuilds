
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.6-ffmpeg.patch
# backported, stripped down git commit 36f1e514acd32152dfee7c09d0e5a4e022a5a543
# "Fix erroneous use of $(DESTDIR)."
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.6-destdir.patch
# backported git commit 4439c947c25ead3073fc3cb00b03fbfc0914e81a
# "Check if aux_rect is NULL before dereferencing"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.6-hstack.patch
# rebuilt autofoo files due to the above
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.6-autoreconf.patch

set +e +o pipefail
