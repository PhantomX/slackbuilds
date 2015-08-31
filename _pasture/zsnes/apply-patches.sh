
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fixing compilation without libpng installed
zcat ${SB_PATCHDIR}/${NAME}-1.51-libpng.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.51-archopt-july-23-update.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.51-depbuild.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.51-CC-quotes.patch.gz | patch -p1 -E --backup --verbose

## RPM Fusion
zcat ${SB_PATCHDIR}/${NAME}-1.51-FORTIFY_SOURCE.patch.gz | patch -p2 -E --backup --verbose
# Paul Bender (minimyth)
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/zsnes-1.51-gcc43.patch
zcat ${SB_PATCHDIR}/${NAME}-1.51-pulseaudio.patch.gz | patch -p2 -E --backup --verbose
# Fix gamepad diagonals problem
# http://board.zsnes.com/phpBB3/viewtopic.php?t=12544
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/zsnes-1.51-hat_events.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zsnes-1.51-libpng15.patch
# Fix FTBFS with gcc 4.7
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=667429
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/zsnes-1.51-gcc47.patch
# Fix crash due to passing a non initialized ao_sample_format struct to libao
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/zsnes-1.51-libao-crash.patch

set +e +o pipefail
