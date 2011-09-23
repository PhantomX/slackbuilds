
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Avoid insecure sprintf(), use a system path for lempar.c, patch from Debian
zcat ${SB_PATCHDIR}/sqlite-3.6.23-lemon-system-template.patch.gz | patch -p1 -E --backup --verbose
# Shut up stupid tests depending on system settings of allowed open fd's
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.7.7.1-stupid-openfiles-test.patch

set +e +o pipefail
