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

# switch off test, which is failing only on koji (fork)
ApplyPatch perl-5.14.1-offtest.patch

# Fix code injection in Digest, rhbz #743010, RT#71390, fixed in Digest-1.17.
ApplyPatch perl-5.14.2-digest_eval.patch

# Fix leak with non-matching named captures. rhbz#767597, RT#78266, fixed
# after 5.14.2.
ApplyPatch perl-5.14.2-Don-t-leak-memory-when-accessing-named-capt.patch

# Fix interrupted reading, rhbz#767931, fixed after 5.15.3.
ApplyPatch perl-5.14.2-add-a-couple-missing-LEAVEs-in-perlio_async_run.patch

# Fix searching for Unicode::Collate::Locale data, rhbz#756118, CPANRT#72666,
# fixed in Unicode-Collate-0.87.
ApplyPatch perl-5.14.2-locale-search-inc.patch

# Run safe signal handlers before returning from sigsuspend() and pause(),
# rhbz#771228, RT#107216, fixed after 5.15.6.
ApplyPatch perl-5.14.2-Signal-handlers-must-run-before-sigsuspend-returns.patch

# Stop !$^V from leaking, rhbz#787613, RT#109762, fixed after 5.15.7.
ApplyPatch perl-5.14.2-Stop-V-from-leaking.patch

# Fix find2perl to translate ? glob properly, rhbz#825701, RT#113054
ApplyPatch perl-5.14.2-find2perl-transtate-question-mark-properly.patch

set +e +o pipefail
