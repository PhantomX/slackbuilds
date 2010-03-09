P.E.Op.S./Pete's MesaGL PSX plugin for Linux
--------------------------------------------

Installation: 
-------------

Copy the file "libgpuPeopsMesaGL.so.x.x.x" into the emu's /Plugin directory
The files "gpuPeopsMesaGL.cfg" and "cfgPeopsMesaGL" should be copied together
into another directory (see next section, "cfg" sub dir recommended).
 
Configuration:
--------------

There's a text file called "gpuPeopsMesaGL.cfg" and an executable called
"cfgPeopsMesaGL". Copy both of them together into

a) a main emu sub-directory called "cfg" or
b) directly into the main emu directory or
c) your home directory

If the main emu has a gui to select the plugins, there will be propably
a "Configure" button for the plugin. Use it... a window with all
possible options will appear. The options are stored into the
"gpuPeopsMesaGL.cfg" text file.

So, if there is no gui, you can use a simple text editor to change the
options.
The options are somewhat explained in the cfg-file (see the comments),
a full readme will follow soon (or not so soon)... basically all the options 
of my Windows OpenGL plugin are included, so you can check the Windows
readme for more infos :)


Troubleshooting:
----------------
On certain Linux distros (mostly RedHat/Mandrake ones) the Mesa plugin will
cause seg faults if it is used in combination with the OSS sound plugin.

Here is what CAB posted on my messageboard about the issue:

     From the strace output it showed
     that /lib/i686/libpthread.so.0 was being loaded which for one or
     another reason is different from /lib/libpthread.so.0 - I forced
     a load of the one in /lib instead, and magically it works fine.
     Both libs show to be part of the glibc-2.2.5 package -&- /lib/i686
     is not in my /etc/ld.so.conf, so that particular one I'd assume is
     being called directly.

or, to make it short, try:

     ln -sf /lib/libpthread-0.9.so /lib/i686/libpthread.so.0

and all should work fine :)

Oh, and another way to repair the pthread problem (thanx to Hez Carty):

1. Install/unzip/untar epsxe and plugins
2. Copy libpthread-0.9.so from /lib to the epsxe dir
3. Type 'ln -s libpthread-0.9.so libpthread.so.0' to make a link to the library
4. Type 'export LD_LIBRARY_PATH=$PWD' so that the program looks here for the offending library
5. Run epsxe and enjoy!

And just another one (by Takashi Yano):

#!/bin/sh
mkdir -p lib
for a in `echo /lib/i686/lib*.so.*|sed 's/i686\///g'`
 do ln -fs $a .$a
done
env LD_LIBRARY_PATH=./lib ./epsxe

or simply:

env LD_PRELOAD=libpthread.so.0 ./epsxe

Wowiezowie :)


Test:
-----

You can easily test, if the gpu is installed correctly... just start the
"PsxGpuCheck" application (available on my homepage), a window showing
some rect will appear, if all is fine.
My plugin FPS menu will pop up by hitting the "DEL" key. If
that one is also displayed correctly, chances are good that the plugin
will work with a PSX emu on your system :)

The source of "PsxGpuCheck" is free to use for every psx emu/plugin coder.
All the gpu interface is shown in the small test app, as well as an
example how to load the gpu library dynamically.

nVidia users should use xfree4 and the detonator based nVidia glx. 3dfx users
should also use the newest stuff, I've noticed a texture matrix bug with 3dfx
glx half a year ago (using Mesa 3.2, hopefully that one is fixed).

The plugin library is linked with MesaGL and X11 libraries, you need em to get
the plugin to work.

Check out the linux ports of PCSX and, of course, ePSXe... and...

have fun :)

Pete Bernert

-------------------------------------------------------
License:

Finally... the plugin is now Open Source under GPL. You can get the full sources
from my web site (www.pbernert.com), or from the P.E.Op.S. sourceforge site.


