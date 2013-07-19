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

# Fix a test failure in perl5db.t when TERM=vt100, RT#118817
ApplyPatch perl-5.18.0-Disable-ornaments-on-perl5db-AutoTrace-tests.patch

# Fix regmatch pointer 32-bit wraparound regression, RT#118175
ApplyPatch perl-5.18.0-Fix-regmatch-pointer-32-bit-wraparound-regression.patch

# Prevent from loading system Term::ReadLine::Gnu while running tests,
# RT#118821
ApplyPatch perl-5.18.0-Suppress-system-Term-ReadLine-Gnu.patch

# Define SONAME for libperl.so
ApplyPatch perl-5.16.3-create_libperl_soname.patch

# Install libperl.so to -Dshrpdir value
ApplyPatch perl-5.16.3-Install-libperl.so-to-shrpdir-on-Linux.patch

# Link XS modules to libperl.so with EU::CBuilder on Linux, bug #960048
ApplyPatch perl-5.16.3-Link-XS-modules-to-libperl.so-with-EU-CBuilder-on-Li.patch

# Link XS modules to libperl.so with EU::MM on Linux, bug #960048
ApplyPatch perl-5.16.3-Link-XS-modules-to-libperl.so-with-EU-MM-on-Linux.patch

set +e +o pipefail
