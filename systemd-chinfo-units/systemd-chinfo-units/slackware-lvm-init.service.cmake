[Unit]
Description=Initialize storage subsystems (RAID, LVM, etc.)
DefaultDependencies=no
Conflicts=shutdown.target
Before=cryptsetup.target local-fs.target shutdown.target

[Service]
ExecStart=@SYSTEMD_INSTALL_DIR@/slackware-lvm-init
Type=oneshot
TimeoutSec=0
RemainAfterExit=yes
