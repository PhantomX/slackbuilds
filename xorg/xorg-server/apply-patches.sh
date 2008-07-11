
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose || exit 1

# Patches from Arch
zcat ${SB_PATCHDIR}/xorg-mesa-source.diff.gz | patch -p1 --verbose || exit 1

# Patches from other vendors
zcat ${SB_PATCHDIR}/001_ubuntu_add_extra_modelines_from_xorg.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/002_libvgahw_gcc4_volatile_fix.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/005_kill_type1.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/006_use_proc_instead_of_sysfs_for_pci_domains.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/010_dont_look_in_home_for_config.diff.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/011_dont_crash_on_bad_dri_mode.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/014_default_screen_section.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/021_glx_align_fixes.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/041_vbe_filter_less.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/043_allow_override_BIOS_EDID_preferred_mode.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/044_preferredmode_infinite_loop.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/045_only_XF86_APM_CAPABILITY_CHANGED_for_video_change_acpi_events.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/046_reduce_wakeups_from_smart_scheduler.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/101_fedora-apm-typedefs.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/102_ubuntu_sharevts_load_cpu.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/104_fedora_init_origins_fix.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/107_fedora_dont_backfill_bg_none.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/108_fedora_honor_displaysize.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/109_glx_fail_if_no_texture_bound.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/110_fedora_no_move_damage.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/120_fedora_xserver-xaa-evict-pixmaps.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/121_only_switch_vt_when_active.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/139_fedora_xserver-1.3.0-document-fontpath-correctly.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/142_fedora_xserver-1.3.0-no-pseudocolor-composite.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/144_fedora_xserver-1.3.0-xnest-exposures.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/149_add_quirks_for_physical_screen_size_issues.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/150_edid_quirk_lp154w01.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/152_xserver_exa_force_greedy.patch.gz | patch -p1 --verbose || exit 1

# Patches from Gentoo
zcat ${SB_PATCHDIR}/1.4-fpic-libxf86config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1.4-document-new-font-catalogs.patch.gz | patch -p1 --verbose || exit 1
