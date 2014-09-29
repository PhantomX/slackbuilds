
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CVE-2007-6061.patch

sed -e "s|__RPM_LIBDIR__|/usr/lib${LIBDIRSUFFIX}|g" \
  ${SB_PATCHDIR}/${NAME}-2.0.6-libdir.patch | patch -p1 -E --backup --verbose

sed \
  -e "s|__RPM_LIBDIR__|/usr/lib${LIBDIRSUFFIX}|g" \
  ${SB_PATCHDIR}/${NAME}-2.0.4-libmp3lame-default.patch | patch -p0 -E --backup --verbose

# Substitute occurences of "libmp3lame.so" with "${SOLAME}".
for i in locale/*.po src/export/ExportMP3.cpp src/AudacityApp.cpp
do
  sed -i \
    -e "s!libmp3lame\.so\.0\b!${SOLAME}!g" \
    -e "s!libmp3lame\.so\([^.]\)!${SOLAME}\1!g" \
    ${i}
done

### Debian
#[ "${SB_FFMPEG}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ffmpeg.patch

set +e +o pipefail
