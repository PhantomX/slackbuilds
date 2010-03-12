
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Fix build with --enable-load-extension, upstream ticket #3137
zcat ${SB_PATCHDIR}/sqlite-3.6.6.2-libdl.patch.gz | patch -p1 -E --backup --verbose
# Avoid insecure sprintf(), use a system path for lempar.c, patch from Debian
zcat ${SB_PATCHDIR}/sqlite-3.6.23-lemon-system-template.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
