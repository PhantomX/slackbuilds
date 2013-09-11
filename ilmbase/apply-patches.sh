
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# explicitly add $(PTHREAD_LIBS) to libIlmThread linkage (helps workaround below)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.1-no_undefined.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-pkgconfig.patch

set +e +o pipefail
