
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/mltframework/mlt/commit/97c2dd0de4f578ad40d547eddf78fcb1e4a008a4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mlt-ffmpeg-master.patch

set +e +o pipefail
