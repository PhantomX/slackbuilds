
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-multilib.patch
# Bug #769597, fixed by upstream after 8.21.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-Do-not-make-unmatched-subpattern-wildcard.patch
# Upstream bug #1186, fixed by upstream after 8.21.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-Do-not-dereference-NULL-argument-of-pcre_free_study.patch

set +e +o pipefail
