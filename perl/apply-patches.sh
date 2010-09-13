  #!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

PATCHCOM="patch -p1 -F1 -s --verbose"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose ${SB_PATCHDIR}/${NAME}.patch

if [ "$ARCH" = "x86_64" ]; then # adopted from "Cross Linux From Scratch"
  # Configure must be told to also use lib64:
  ApplyPatch perl.configure.multilib.patch.gz
  # "perl -V" should report that libc is in /lib64
  sed -i -e '/libc/s#/lib/#/lib64/#' hints/linux.sh
  # make perl use lib64:
  echo 'installstyle="lib64/perl5"' >>hints/linux.sh
fi

# Fedora/RHEL specific (use libresolv instead of libbind)
ApplyPatch perl-5.10.0-libresolv.patch

# FIXME: May need the "Fedora" references removed before upstreaming
# patches ExtUtils-MakeMaker
ApplyPatch perl-USE_MM_LD_RUN_PATH.patch

# Skip hostname tests, since hostname lookup isn't available in Fedora
# buildroots by design.
# patches Net::Config from libnet
ApplyPatch perl-disable_test_hosts.patch

# The Fedora builders started randomly failing this futime test
# only on x86_64, so we just don't run it. Works fine on normal
# systems.
ApplyPatch perl-5.10.0-x86_64-io-test-failure.patch

# temporarily export debug symbols even though DEBUGGING is not set:
#ApplyPatch perl-add-symbols.patch

# Do not leak when destroying thread; RT #77352, RHBZ #630667
ApplyPatch perl-5.12.1-fix_thread_leak.patch

set +e +o pipefail
