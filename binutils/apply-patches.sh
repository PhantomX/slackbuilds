
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-libtool-lib64.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-version.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-set-long-long.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-copy-osabi.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-sec-merge-emit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-weakdef.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-ld-13621.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-rh797752.patch
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-relro-on-by-default.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-x86_64-hidden-ifunc.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-tsx.patch

set +e +o pipefail
