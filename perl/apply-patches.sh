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

# Fix find2perl to translate ? glob properly, rhbz#825701, RT#113054
ApplyPatch perl-5.14.2-find2perl-transtate-question-mark-properly.patch

# Update h2ph(1) documentation, rhbz#948538, RT#117647
ApplyPatch perl-5.19.0-Synchronize-h2ph-POD-text-with-usage-output.patch

# Update pod2html(1) documentation, rhbz#948538, RT#117623
ApplyPatch perl-5.16.3-Synchronize-pod2html-usage-output-and-its-POD-text.patch

# Fix a test failure in perl5db.t when TERM=vt100, RT#118817,
# in upstream after 5.19.7
ApplyPatch perl-5.19.7-avoid-using-2-handles-to-write-to-the-de.patch

# Prevent from loading system Term::ReadLine::Gnu while running tests,
# RT#118821
ApplyPatch perl-5.18.0-Suppress-system-Term-ReadLine-Gnu.patch

# Define SONAME for libperl.so
ApplyPatch perl-5.16.3-create_libperl_soname.patch

# Install libperl.so to -Dshrpdir value
ApplyPatch perl-5.16.3-Install-libperl.so-to-shrpdir-on-Linux.patch

# Fix crash with \&$glob_copy, rhbz#989486, RT#119051
# Update the upstream patch to work for Perl 5.18.1
ApplyPatch perl-5.19.2-Fix-crash-with-glob_copy.patch

# Fix coreamp.t's rand test, rhbz#970567, RT#118237
ApplyPatch perl-5.19.2-Fix-coreamp.t-s-rand-test.patch

# Reap child in case where exception has been thrown, rhbz#988805, RT#114722
ApplyPatch perl-5.19.3-Reap-child-in-case-where-exception-has-been-thrown.patch

# Fix using regular expressions containing multiple code blocks,
# rhbz#982131, RT#117917
# Update the upstream patch to work for Perl 5.18.1
ApplyPatch perl-5.19.2-Fix-using-regexes-with-multiple-code-blocks.patch

# Document Math::BigInt::CalcEmu requires Math::BigInt, rhbz#959096,
# CPAN RT#85015
ApplyPatch perl-5.18.1-Document-Math-BigInt-CalcEmu-requires-Math-BigInt.patch

# Fix t/comp/parser.t not to load system modules, bug #1084399, RT#121579,
# in upstream after 5.19.1
ApplyPatch perl-5.18.2-Make-t-comp-parser.t-get-the-correct-libraries.patch

# Pass -fwrapv to stricter GCC 4.9, bug #1082957, RT#121505,
# in upstream after 5.19.10
ApplyPatch perl-5.18.2-Pass-fwrapv-to-stricter-GCC-4.9.patch

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
