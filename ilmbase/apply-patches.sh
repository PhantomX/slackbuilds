
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# explicitly add $(PTHREAD_LIBS) to libIlmThread linkage (helps workaround below)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.2-no_undefined.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-pkgconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-secondary.patch
# https://github.com/openexr/openexr/issues/3
[ "${ARCH}" = "x86_64" ] || patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-ucontext.patch

set +e +o pipefail
