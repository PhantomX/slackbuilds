
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# https://bugzilla.redhat.com/show_bug.cgi?id=904614
sed -e "s|/etc/pki/tls|${SB_CABDIR}|g" ${SB_PATCHDIR}/${NAME}-system-cert-bundle.patch \
  | patch -p1 -E --backup --verbose
# Remove an unnecessary reference to a bundled compat lib in urllib3
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-remove-nested-bundling-dep.patch
# Backport fix for CVE-2015-2296
# https://github.com/kennethreitz/requests/commit/3bd8afbff29e50b38f889b2f688785a669b9aafc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dont-ascribe-cookies.patch

set +e +o pipefail
