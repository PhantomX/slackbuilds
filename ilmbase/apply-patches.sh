
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-so6.patch
# explicitly add $(PTHREAD_LIBS) to libIlmThread linkage (helps workaround below)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.2-no_undefined.patch
# https://github.com/openexr/openexr/issues/3
[ "${ARCH}" = "x86_64" ] || patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-ucontext.patch

set +e +o pipefail
