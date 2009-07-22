  
SB_PATCHDIR=${CWD}/patches
zcat ${SB_PATCHDIR}/${NAME}-0.9.15-no-daemon-if-remote-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-allow-configuration-of-fallback-device-strings.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-util-if-NULL-is-passed-to-pa_path_get_filename-ju.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-don-t-hit-an-assert-when-invalid-module-argume.patch.gz | patch -p1 -E --backup --verbose || exit 1.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-fix-wording-we-are-speaking-of-card-profiles.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-initialize-buffer-size-before-number-of-period.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-conf-remove-obsolete-module-idle-time-directive-fro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-core-make-sure-soft-mute-status-stays-in-sync-with.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-endian-fix-LE-BE-order-for-24-bit-accessor-function.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-log-print-file-name-only-when-we-have-it.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-man-document-24bit-sample-types-in-man-page.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-man-document-log-related-daemon.conf-options.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-man-document-that-tsched-doesn-t-use-fragment-setti.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-mutex-when-we-fail-to-fill-in-mutex-into-static-mut.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-oss-don-t-deadlock-when-we-try-to-resume-an-OSS-dev.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-simple-protocol-don-t-hit-an-assert-when-we-call-co.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-idxset-add-enumeration-macro-PA_IDXSET_FOREACH.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-rescue-streams-when-one-stream-move-fails-try-to-co.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-sample-correctly-pass-s24-32-formats.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-sample-util-fix-iteration-loop-when-adjusting-volum.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-sample-util-properly-allocate-silence-block-for-s24.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-sconv-fix-a-few-minor-conversion-issues.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-be-a-bit-more-verbose-when-a-hwparam-call-fail.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-rescue-make-we-don-t-end-up-in-an-endless-loop-when.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-core-introduce-pa_-sink-source-_set_fixed_latency.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-core-cache-requested-latency-only-when-we-are-runni.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-sample-fix-build-on-BE-archs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-properly-convert-return-values-of-snd_strerror.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-alsa-remove-debug-code.patch.gz | patch -p1 -E --backup --verbose || exit 1
