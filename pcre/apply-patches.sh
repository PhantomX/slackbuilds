
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.21-multilib.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-bug-when-there-are-unset-groups-prior-to-ACCEPT-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-zero-repeat-assertion-condition-bug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Remove-computing-the-JIT-read-only-data-size-in-adva.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-memory-bug-for-S-V-H-compile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-mutual-recursion-inside-other-groups-stack-overf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-comment-between-subroutine-call-and-quantifier-b.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-stack-overflow-instead-of-diagnostic-for-mutual-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-pcregrep-loop-when-K-is-used-in-a-lookbehind-ass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-pcretest-loop-for-K-in-lookbehind-assertion.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pcre-8.36-Fix-backtracking-bug-for-C-X-in-UTF-mode.patch


set +e +o pipefail
