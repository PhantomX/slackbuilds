[Unit]
Description=Clean dead service files on /etc/systemd/system
DefaultDependencies=no
Wants=local-fs.target
After=local-fs.target sysinit.target
Before=poweroff.target reboot.target shutdown.target
ConditionDirectoryNotEmpty=|/etc/systemd/system

[Service]
Type=oneshot
ExecStart=@SYSTEMD_INSTALL_DIR@/systemd-clean-dead-links
 
