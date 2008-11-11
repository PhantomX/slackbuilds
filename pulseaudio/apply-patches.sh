  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/0001-Initialize-exit_idle_time-to-1-instead-of-0-when-i.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0002-Unload-module-bluetooth-device-if-the-remote-device.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0003-instead-of-resetting-virtual_volume-unconditionally.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0004-use-pa_channel_map_init_extend-instead-of-pa_chann.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0005-if-the-channel-map-was-modified-due-to-PA_SINK_INPUT.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0006-define-0dB-in-PA-as-maximum-amplification.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0007-Fix-a-potential-C-C99-ism-add-a-log-message-on-er.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0008-Fix-two-typos-that-broke-tunnels.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0009-properly-remove-dbus-matches-an-filters-when-unloadi.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0010-Fix-possible-invalid-read-while-attempting-to-load-m.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0011-always-check-for-libtool-prefix-binary-name-to-avoid.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0012-Fix-spelling-of-privilige.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0013-Make-missing-git-changelog.perl-non-fatal.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0014-fix-invalid-validity-check.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0015-convert-argument-to-boolean-int-in-PA_UNLIKELY-too.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0016-include-log.h-near-the-end-so-that-macro.h-can-be-in.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0017-Try-to-catch-certain-driver-errors.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0018-make-the-debug-trap-macro-a-proper-macro-in-macro.h.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0019-don-t-set-the-volume-of-pacat-unless-it-is-explicitl.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0020-warn-if-ALSA-wakes-us-up-and-there-is-actually-nothi.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0021-fix-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0022-make-sure-to-use-64bit-rounding-even-on-32bit-machin.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0023-make-shm-marker-architecture-independant-patch-from.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0024-Make-sure-libpulse-never-gets-unloaded.patch.gz | patch -p1 -E --backup --verbose || exit 1
