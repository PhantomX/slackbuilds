
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemctl-fix-issue-with-systemctl-daemon-reexec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-load-fragment-initialize-bool-invert-before-use.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-login-check-return-of-parse_pid-and-parse_uid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-core-free-word-later-in-parse_proc_cmdline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-readahead-analyze-don-t-call-fclose-on-null.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-hashmap-hashmap_contains-does-not-need-hashmap_entry.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-sd-journal-return-null-when-mmap_cache_new-fails.patch
  
set +e +o pipefail
