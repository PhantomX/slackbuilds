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

ApplyPatch porting-podcheck-regen.patch

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

# Fix broken atof, rhbz#835452, RT#109318
ApplyPatch perl-5.16.0-fix-broken-atof.patch

# Do not access freed memory when cloning thread, rhbz#825749, RT#111610
ApplyPatch perl-5.16.1-perl-111610-Trouble-with-XS-APItest-t-clone-with-sta.patch

# Clear $@ before `do' I/O error, rhbz#834226, RT#113730
ApplyPatch perl-5.16.1-RT-113730-should-be-cleared-on-do-IO-error.patch

# Do not truncate syscall() return value to 32 bits, rhbz#838551, RT#113980
ApplyPatch perl-5.16.1-perl-113980-pp_syscall-I32-retval-truncates-the-retu.patch

# Override the Pod::Simple::parse_file, rhbz#826872, CPANRT#77530, in
# podlators-2.4.1
ApplyPatch perl-5.14.2-Override-the-Pod-Simple-parse_file.patch

# Do not leak with attribute on my variable, rhbz#858966, RT#114764,
# fixed after 5.17.4
ApplyPatch perl-5.16.1-perl-114764-Stop-my-vars-with-attrs-from-leaking.patch

# Allow operator after numeric keyword argument, rhbz#859328, RT#105924,
# fixed after 5.17.4
ApplyPatch perl-5.16.1-perl-105924-require-1-2.patch

# Extend stack in File::Glob::glob, rhbz#859332, RT#114984, fixed after 5.17.4
ApplyPatch perl-5.16.1-perl-114984-Glob.xs-Extend-stack-when-returning.patch

# Do not crash when vivifying $|, rhbz#865296, RT#115206
ApplyPatch perl-5.16.1-perl-115206-Don-t-crash-when-vivifying.patch

set +e +o pipefail
