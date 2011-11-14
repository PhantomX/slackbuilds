
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
touch -r m4/optimizations.m4 m4/optimizations.m4.stamp
zcat ${SB_PATCHDIR}/${NAME}-1.1.3-optflags.patch.gz | patch -p1 -E --backup --verbose
touch -r m4/optimizations.m4.stamp m4/optimizations.m4
touch -r m4/pthreads.m4 m4/pthreads.m4.stamp
touch -r m4/pthreads.m4.stamp m4/pthreads.m4
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-deepbind-939.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.redhat.com/470568
zcat ${SB_PATCHDIR}/${NAME}-1.1.17-avsync_hack.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.redhat.com/477226
zcat ${SB_PATCHDIR}/${NAME}-1.1.16.2-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
