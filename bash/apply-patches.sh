
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}${SVER//.}-${i}
  done
fi

# Other patches
zcat ${SB_PATCHDIR}/${NAME}-2.02-security.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .paths --verbose -i ${SB_PATCHDIR}/bash-2.03-paths.patch
zcat ${SB_PATCHDIR}/${NAME}-2.03-profile.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.05a-interpreter.patch
zcat ${SB_PATCHDIR}/${NAME}-2.05b-debuginfo.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.05b-manso.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.05b-pgrp_sync.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .readline_oom --verbose -i ${SB_PATCHDIR}/bash-2.05b-readline-oom.patch
zcat ${SB_PATCHDIR}/${NAME}-2.05b-xcc.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-3.2-audit.patch
zcat ${SB_PATCHDIR}/${NAME}-3.2-ssh_source_bash.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-infotags.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .requires --verbose -i ${SB_PATCHDIR}/bash-requires.patch
zcat ${SB_PATCHDIR}/${NAME}-setlocale.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-tty-tests.patch

# check if interp section is NOBITS
zcat ${SB_PATCHDIR}/${NAME}-4.0-nobits.patch.gz | patch -p1 -E --backup --verbose
# Do the same CFLAGS in generated Makefile in examples
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.1-examples.patch
# Builtins like echo and printf won't report errors
# when output does not succeed due to EPIPE
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.1-broken_pipe.patch
# Enable system-wide .bash_logout for login shells
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.2-rc2-logout.patch
# Static analyzis shows some issues in bash-2.05a-interpreter.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.2-coverity.patch
# Don't call malloc in signal handler
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.1-defer-sigchld-trap.patch
# rh#799958, updated info about trap
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.2-manpage_trap.patch
# https://www.securecoding.cert.org/confluence/display/seccode/INT32-C.+Ensure+that+operations+on+signed+integers+do+not+result+in+overflow
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.2-size_type.patch
# rhbz#1112710 - mention ulimit -c and -f POSIX block size
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-man-ulimit.patch
# A series of patches emitted by upstream since 4.3-18
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-pathexp-globignore-delim.patch
# rhbz#1102815 - fix double echoes in vi visual mode
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-noecho.patch
# 1182278 - bash crashes on `select' if REPLY is readonly
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-select-readonly.patch
#1241533,1224855 - bash leaks memory when LC_ALL set
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-memleak-lc_all.patch
#1245233 - old memleak reappeared, taken from upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bash-4.3-old-memleak.patch

set +e +o pipefail
