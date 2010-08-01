
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .nomac --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.12-nomac.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.12-automagic.patch
zcat ${SB_PATCHDIR}/${NAME}-CVE-2007-6061.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.12-ffmpeg.patch

sed -e "s|__RPM_LIBDIR__|/usr/lib${LIBDIRSUFFIX}|g" \
  ${SB_PATCHDIR}/${NAME}-1.3.7-libmp3lame-default.patch | patch -p1 -E --backup --verbose
sed -e "s|__RPM_LIBDIR__|/usr/lib${LIBDIRSUFFIX}|g" \
  ${SB_PATCHDIR}/${NAME}-1.3.9-libdir.patch | patch -p1 -E --backup --verbose

set +e +o pipefail
