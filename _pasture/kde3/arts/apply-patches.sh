
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.tmpdir.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.4-debug.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.3.92-glib2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.3.1-alsa.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.5.8-glibc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.5.2-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/arts-1.5.10-cpu-overload-quiet.patch.gz | patch -p1 -E --backup --verbose
# don't call snd_pcm_close(NULL), triggers assertion failure in ALSA (#558570)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/arts-1.5.10-assertion-failure.patch
# kde#93359
zcat ${SB_PATCHDIR}/${NAME}-1.5.4-dlopenext.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kde-3.5-libtool-shlibext.patch.gz | patch -p1 -E --backup --verbose

# security patches
# CVE-2009-3736 libtool: libltdl may load and execute code from a library in the current directory 
zcat ${SB_PATCHDIR}/libltdl-CVE-2009-3736.patch.gz | patch -p1 -E --backup --verbose

# tweak autoconfigury so that it builds with autoconf 2.64 or 2.65
zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
