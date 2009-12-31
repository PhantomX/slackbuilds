  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.tmpdir.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.4-debug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3.92-glib2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3.1-alsa.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5.8-glibc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5.2-multilib.patch.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/arts-1.5.10-cpu-overload-quiet.patch.gz | patch -p1 -E --backup --verbose || exit 1
# kde#93359
zcat ${SB_PATCHDIR}/${NAME}-1.5.4-dlopenext.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/kde-3.5-libtool-shlibext.patch.gz | patch -p1 -E --backup --verbose || exit 1

# security patches
# CVE-2009-3736 libtool: libltdl may load and execute code from a library in the current directory 
zcat ${SB_PATCHDIR}/libltdl-CVE-2009-3736.patch.gz | patch -p1 -E --backup --verbose || exit 1

# tweak autoconfigury so that it builds with autoconf 2.64 or 2.65
zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 -E --backup --verbose || exit 1
