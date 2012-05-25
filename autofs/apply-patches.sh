
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    patch -p1 --verbose -i ${SB_PATCHDIR}/updates/${file}
  done
fi

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.6-fix-initialization-in-rpc-create_client.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.6-fix-libtirpc-name-clash.patch

### Patches from gentoo
# Accumulated fixes for bugs
#    #154797: Respect CC and CFLAGS
#    #253412: Respect LDFLAGS
#    #247969: Link order for --as-needed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.6-respect-user-flags-and-fix-asneeded-r2.patch
# Upstream reference: http://thread.gmane.org/gmane.linux.kernel.autofs/5371
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.5-fix-install-deadlink.patch
# Upstream reference: http://thread.gmane.org/gmane.linux.kernel.autofs/6039
# Disable LDAP specific code if USE="-ldap", let's see what upstream says...
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.5-fix-building-without-ldap.patch
# https://bugs.gentoo.org/show_bug.cgi?id=361899
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.5-add-missing-endif-HAVE_SASL-in-modules-lookup_ldap.c.patch
# https://bugs.gentoo.org/show_bug.cgi?id=381315
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autofs-5.0.6-revert-ldap.patch

set +e +o pipefail
