
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-rh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020124-countermeasures.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-addrcache.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-ping-subint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ifenslave.patch
patch -p1 -E --backup -z .idn --verbose -i ${SB_PATCHDIR}/${NAME}-20070202-idn.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20070202-traffic_class.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20070202-ia64_align.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20071127-corr_type.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20071127-infiniband.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20100418-convtoint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20100418-flowlabel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-unused.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-eth.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-rr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-ping-integer-overflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20101006-ping-fallback-to-numeric-addresses-while-exiting.patch

set +e +o pipefail
