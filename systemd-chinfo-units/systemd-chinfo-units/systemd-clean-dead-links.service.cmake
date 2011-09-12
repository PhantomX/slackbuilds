[Unit]
Description=Clean dead service files on /etc/systemd/system
DefaultDependencies=no
After=local-fs.target sysinit.target
Before=poweroff.target reboot.target shutdown.target


[Service]
Type=oneshot
ExecStart=@SYSTEMD_INSTALL_DIR@/systemd-clean-dead-links
 
