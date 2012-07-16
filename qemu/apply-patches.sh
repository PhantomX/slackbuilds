
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-kvm-Enable-use-of-kvm_irqchip_in_kernel-in-hwlib-cod.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Replace-struct-siginfo-with-siginfo_t.patch

set +e +o pipefail
