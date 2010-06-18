
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/js-1.7.0-make.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/js-shlib.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js-1.5-va_copy.patch
zcat ${SB_PATCHDIR}/js-ldflags.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/js-1.7.0-threadsafe.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/js-1.60-ncurses.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
