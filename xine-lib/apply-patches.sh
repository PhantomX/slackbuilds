
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
touch -r configure.ac configure.ac.stamp
patch -p1 -E --backup -z .opt --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.0-optflags.patch
touch -r configure.ac.stamp configure.ac
touch -r m4/pthreads.m4 m4/pthreads.m4.stamp
touch -r m4/pthreads.m4.stamp m4/pthreads.m4
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-deepbind-939.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.redhat.com/470568
zcat ${SB_PATCHDIR}/${NAME}-1.1.17-avsync_hack.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.redhat.com/477226
zcat ${SB_PATCHDIR}/${NAME}-1.1.16.2-multilib.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.1-ffmpeg.patch

set +e +o pipefail
