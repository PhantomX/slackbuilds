# Building Clementine on Slackware64 -current multilib

Make sure you have all the dependencies from slack-required in place. Bellow
you'll find some rough instructions to build some troublesome ones. If you just
clone [PhamtomX's](https://github.com/PhantomX/slackbuilds), then you should
make the modifications bellow. If you clone my slackbuilds (which is a fork from
PhantomX ones), the code are all set. Just follow the package order.

Install gmock from [this](http://ftp.slackware.com/pub/vectorlinux/VL64-7.1/extra/Library/gmock-1.6.0-x86_64-1vl71.txz) package.

Build from PhantomX slackbuilds:

```
libechonest
libmygpo-qt
libprojectm
```

Instal [libqxt](http://slackbuilds.org/repository/14.0/libraries/libqxt/) from SlackBuilds.org, Slackware 14 repository).

Keep installing PhantomX slackbuilds:

```
qtiocompressor
qtlockedfile
```

```
# ln -s /usr/include/QtSolutions /usr/lib64/qt/include/QtSolutions/o
```

Edit qtsingleapplication/patches/qtsingleapplication-add-api.patch to change
the first chunk to:

```
@@ -48,6 +48,8 @@
 #include "qtlocalpeer.h"
 #include <QtCore/QCoreApplication>
 #include <QtCore/QTime>
+#include <QtDebug>
+#include <unistd.h>

 #if defined(Q_OS_WIN)
 #include <QtCore/QLibrary>
```

Keep installing PhantomX slackbuilds:

```
qtsingleapplication
sha2
clementine
```
