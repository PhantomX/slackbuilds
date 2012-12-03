
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=846481
## upstreamable patches
# allow use of system qtsingleappliation when built in ENABLE_KDE=OFF mode
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.3.1-qtsingleapplication.patch
# s|^#!/usr/bin/env perl|#!/usr/bin/perl|
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.3.1-perl_env.patch

set +e +o pipefail
