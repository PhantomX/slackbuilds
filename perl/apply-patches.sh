  #!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
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

### Fedora

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

# Define SONAME for libperl.so
ApplyPatch perl-5.16.3-create_libperl_soname.patch

# Install libperl.so to -Dshrpdir value
ApplyPatch perl-5.16.3-Install-libperl.so-to-shrpdir-on-Linux.patch

# Document Math::BigInt::CalcEmu requires Math::BigInt, rhbz#959096,
# CPAN RT#85015
ApplyPatch perl-5.18.1-Document-Math-BigInt-CalcEmu-requires-Math-BigInt.patch

# Use stronger algorithm needed for FIPS in t/op/crypt.t, bug #1128032,
# RT#121591
ApplyPatch perl-5.18.2-t-op-crypt.t-Perform-SHA-256-algorithm-if-default-on.patch

# Make *DBM_File desctructors thread-safe, bug #1107543, RT#61912
ApplyPatch perl-5.18.2-Destroy-GDBM-NDBM-ODBM-SDBM-_File-objects-only-from-.patch

# Link XS modules to libperl.so with EU::CBuilder on Linux, bug #960048
ApplyPatch perl-5.16.3-Link-XS-modules-to-libperl.so-with-EU-CBuilder-on-Li.patch

# Link XS modules to libperl.so with EU::MM on Linux, bug #960048
ApplyPatch perl-5.16.3-Link-XS-modules-to-libperl.so-with-EU-MM-on-Linux.patch

set +e +o pipefail
