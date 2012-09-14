
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .slk --verbose -i ${SB_PATCHDIR}/${NAME}-slkcflags.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dso.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-unknown-configure-opt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-glibc-2.10.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.9998_pre20120806-qa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.9998_pre20110817-kash-link-pthread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.9998_pre20110817-gold.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.9998_pre20110817-gcc-4.7.patch
    
set +e +o pipefail
