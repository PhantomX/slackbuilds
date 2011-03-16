
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-libtool-lib64.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-set-long-long.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-copy-osabi.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-sec-merge-emit.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.21.51.0.6-gold-plugins.patch

set +e +o pipefail
