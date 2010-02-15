  #!/bin/sh

set -e

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

if [ "$ARCH" = "x86_64" ]; then # adopted from "Cross Linux From Scratch"
  # Configure must be told to also use lib64:
  ApplyPatch perl.configure.multilib.patch.gz
  # "perl -V" should report that libc is in /lib64
  sed -i -e '/libc/s#/lib/#/lib64/#' hints/linux.sh
  # make perl use lib64:
  echo 'installstyle="lib64/perl5"' >>hints/linux.sh
fi

ApplyPatch perl-suid-noroot.patch

# Fedora/RHEL specific (use libresolv instead of libbind)
ApplyPatch perl-5.10.0-libresolv.patch

# FIXME: May need the "Fedora" references removed before upstreaming
# patches ExtUtils-MakeMaker
ApplyPatch perl-USE_MM_LD_RUN_PATH.patch

# Skip hostname tests, since hostname lookup isn't available in Fedora
# buildroots by design.
# patches Net::Config from libnet
ApplyPatch perl-5.10.0-disable_test_hosts.patch

# The Fedora builders started randomly failing this futime test
# only on x86_64, so we just don't run it. Works fine on normal
# systems.
ApplyPatch perl-5.10.0-x86_64-io-test-failure.patch

# Reorder @INC: Based on: http://github.com/rafl/perl/commit/b9ba2fadb18b54e35e5de54f945111a56cbcb249
ApplyPatch perl-5.10.0-reorderINC.patch

# http://rt.perl.org/rt3/Ticket/Display.html?id=39060 (#221113)
ApplyPatch perl-perlio-incorrect-errno.patch

# much better swap logic to support reentrancy and fix assert failure
# http://perl5.git.perl.org/perl.git/commitdiff/e9105d30edfbaa7f444bc7984c9bafc8e991ad12
# RT #60508
ApplyPatch perl-much-better-swap-logic.patch

# temporarily export debug symbols even though DEBUGGING is not set:
#ApplyPatch perl-add-symbols.patch

# CVE_2009_3626 rhbz#547656 
ApplyPatch perl-5.10.1-CVE_2009_3626.patch

# Update some of the bundled modules

ApplyPatch perl-update-ExtUtils-CBuilder.patch
ApplyPatch perl-update-File-Path.patch
ApplyPatch perl-update-Module-Build.patch

#... also update version number of Compress::Zlib
ApplyPatch perl-update-Parse-CPAN-Meta.patch

set +e
