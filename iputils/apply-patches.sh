
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-rh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020124-countermeasures.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-addrcache.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-ping-subint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ping_cleanup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ifenslave.patch
patch -p1 -E --backup -z .idn --verbose -i ${SB_PATCHDIR}/${NAME}-20100418-idn.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20070202-traffic_class.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20070202-ia64_align.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20071127-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20071127-corr_type.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20071127-infiniband.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20100418-convtoint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20100418-flowlabel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-drop_caps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-unused.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-man.patch
# Fix raprd build with FORTIFY_SOURCE
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-rarpd-fortify.patch

set +e +o pipefail
