
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-v0.8.5_tos.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/htb_0.8.5_ipv6.diff.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/htb_0.8.5_esfq.diff.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/prio_rule.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/timecheck_fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}_find_fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
