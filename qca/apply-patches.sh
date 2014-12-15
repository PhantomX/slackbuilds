
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-dropped-unused-include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-cmake-pkg-config-is-not-REQUIRED.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-qca-ossl-fixed-compilation-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-cmake-dropped-dead-variable.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Fix-build-with-libressl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-increased-minimum-cmake-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-cmake-warn-user-when-QCA_SUFFIX-is-not-set.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-cmake-apply-QCA_SUFFIX-for-cmake-config-module-names.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-cmake-build-for-android.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-fixed-compilation-on-android.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-simplified-md5_state_t-and-SHA1_CONTEXT-internal-str.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-cmake-fixed-warnings-on-android.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-docs-fixed-no-images-in-docs-when-build-out-of-sourc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-cmake-fixed-cmake-config-module-when-used-QCA_SUFFIX.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0015-fix-library-name-in-prf-file-to-use-the-lib-name-var.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0016-move-QCA_CONFIG_NAME_BASE-definition-in-the-regular-.patch


set +e +o pipefail
