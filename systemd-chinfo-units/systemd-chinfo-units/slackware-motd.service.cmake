[Unit]
Description=Update the current kernel level in the /etc/motd
Before=systemd-user-sessions.service
After=syslog.target local-fs.target

[Service]
Type=oneshot
RemainAfterExit=no
ExecStart=@SYSTEMD_INSTALL_DIR@/slackware-motd
