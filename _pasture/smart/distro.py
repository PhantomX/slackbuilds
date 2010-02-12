if not sysconf.getReadOnly():
    if not sysconf.has("channels"):
        sysconf.set(("channels", "rpm-db"),
                    {"alias": "rpm-db",
                     "type": "rpm-sys",
                     "name": "RPM Database"})

    for flavour in ("", "-smp", "-bigmem", "-hugemem", "-largesmp", "-PAE", "-xen", "-xen0", "-xenU", "-kdump"):
        pkgconf.setFlag("multi-version", "kernel%s" % flavour)
        pkgconf.setFlag("multi-version", "kernel%s-unsupported" % flavour)
        pkgconf.setFlag("multi-version", "kernel%s-devel" % flavour)
        for clustergfs in ("GFS", "cman", "dlm", "gnbd"):
             pkgconf.setFlag("multi-version", "%s-kernel%s" % (clustergfs, flavour))
        pkgconf.setFlag("multi-version", "kernel-suspend2%s" % flavour)
        pkgconf.setFlag("multi-version", "kernel-suspend2%s-unsupported" % flavour)
        pkgconf.setFlag("multi-version", "kernel-suspend2%s-devel" % flavour)
        for clustergfs in ("GFS", "cman", "dlm", "gnbd"):
             pkgconf.setFlag("multi-version", "%s-kernel-suspend2%s" % (clustergfs, flavour))
    pkgconf.setFlag("multi-version", "kernel-source")
    pkgconf.setFlag("multi-version", "kernel-sourcecode")

import os
import os.path

DISTRODIR = "/etc/smart/distro.d"

if os.path.isdir(DISTRODIR):
    for f in map(lambda x: os.path.join(DISTRODIR, x), os.listdir(DISTRODIR)):
        if f.endswith(".py") and os.path.isfile(f):
            execfile(f, {"ctrl": ctrl, "iface": iface, "sysconf": sysconf,
                         "pkgconf": pkgconf, "hooks": hooks})
