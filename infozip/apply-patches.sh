
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${UNZIPSRCDIR}
  ### Fedora
  # Not sent to upstream.
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-bzip2-configure.patch
  # Upstream plans to do this in zip (hopefully also in unzip).
  zcat ${SB_PATCHDIR}/unzip-6.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose
  # Upstream plans to do similar thing.
  zcat ${SB_PATCHDIR}/unzip-6.0-close.patch.gz | patch -p1 -E --backup --verbose
  # Details in rhbz#532380.
  # Reported to upstream: http://www.info-zip.org/board/board.pl?m-1259575993/
  zcat ${SB_PATCHDIR}/unzip-6.0-attribs-overflow.patch.gz | patch -p1 -E --backup --verbose
  # This also resolves the license issue in that old function.
  # Original came from here: https://projects.parabolagnulinux.org/abslibre.git/plain/libre/unzip-libre/match.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-fix-recmatch.patch
  # Update process.c
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-symlink.patch
  # change using of macro "case_map" by "to_up"
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-caseinsensitive.patch
  # downstream fix for "-Werror=format-security"
  # upstream doesn't want hear about this option again
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-format-secure.patch

  ### Debian
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04-handle-pkware-verification-bit.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05-fix-uid-gid-handling.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/07-increase-size-of-cfactorstr.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/08-allow-greater-hostver-values.patch
)

( cd ${ZIPSRCDIR}
  ### Fedora
  # This patch will probably be merged to zip 3.1
  # http://www.info-zip.org/board/board.pl?m-1249408491/
  zcat ${SB_PATCHDIR}/zip-3.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose
  # Not upstreamed.
  zcat ${SB_PATCHDIR}/zip-3.0-currdir.patch.gz | patch -p1 -E --backup --verbose

  ### Gentoo
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-build.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-no-crypt.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-pic.patch.gz | patch -p0 -E --backup --verbose

  ### Debian
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/07-fclose-in-file-not-fclose-x.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/08-hardening-build-fix-1.patch
)

set +e +o pipefail
