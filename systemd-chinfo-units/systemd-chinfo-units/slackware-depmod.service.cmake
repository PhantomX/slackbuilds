[Unit]
Description=Run depmod
DefaultDependencies=no
After=local-fs.target
Before=shutdown.target

[Service]
Type=oneshot
ExecStart=@SYSTEMD_INSTALL_DIR@/slackware-depmod
