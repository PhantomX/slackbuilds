#!/usr/bin/python

# Author: Piotr Zielinski (http://www.cl.cam.ac.uk/~pz215/)
# Licence: GPL 2
# Date: 03.12.2005

# This script takes names of menu files conforming to the XDG Desktop
# Menu Specification, and outputs their FVWM equivalents to the
# standard output.
#
#   http://standards.freedesktop.org/menu-spec/latest/

# Syntax:
#
#   fvwm-xdg-menu.py menufile1 menufile2 menufile3 ...
#
# Each menufile is an XDG menu description file.  Example:
#
#   fvwm-xdg-menu.py /etc/xdg/menus/gnome-applications.menu 

# This script requires the python-xdg module, which in Debian can be
# installed by typing
#
#   apt-get install python-xdg

import sys
import xdg.Menu
import xdg.IconTheme
import xdg.Locale
import optparse
import os.path
import os
from xdg.DesktopEntry import *

usage = """

   %prog [options] file1 file2 ...

This script takes names of menu files conforming to the XDG Desktop
Menu Specification, and outputs their FVWM equivalents to the standard
output.

   http://standards.freedesktop.org/menu-spec/latest/

examples:

   %prog /etc/xdg/menus/gnome-applications.menu
   %prog /etc/xdg/menus/kde-applications.menu
   %prog /etc/xdg/menus/debian-menu.menu"""

parser = optparse.OptionParser(usage=usage)
parser.add_option("-e", "--exec", dest="exec_command", type="string",
                  default="Exec exec",
                  help="FVWM command used to execute programs [Exec exec]")
parser.add_option("-s", "--size", dest="icon_size", type="int",
                  default=24, help="Default icon size [24]")
parser.add_option("-f", "--force", action="store_true", dest="force",
                  default=False,
                  help="Force icon size (requires imagemagick and writes \
                  into ICON_DIR)")
parser.add_option("-i", "--icon-dir", dest="icon_dir", type="string",
                  default="~/.fvwm/icons",
                  help="Directory for converted icons [~/.fvwm/icons]")
parser.add_option("-t", "--theme", dest="theme", type="string",
                  default="gnome",
                  help="Icon theme [gnome]")
parser.add_option("-m", "--top-menu", dest="top", type="string",
                  default="",
                  help="Top menu name")


options, args = parser.parse_args()

def printtext(text):
    print text.encode("utf-8")

def geticonfile(icon, size=options.icon_size, theme=options.theme):
    iconpath = xdg.IconTheme.getIconPath(icon, size, theme, ["png", "xpm"])

    if not iconpath:
        return None

    if not options.force:
        return iconpath
    
    if iconpath.find("%ix%i" % (size, size)) >= 0: # ugly hack!!!
        return iconpath

    printtext(iconpath)
    
    iconfile = os.path.join(os.path.expanduser(options.icon_dir),
                            "%ix%i-" % (size, size) + 
                            os.path.basename(iconpath))
    os.system("if test \\( ! -f '%s' \\) -o \\( '%s' -nt '%s' \\) ; then convert '%s' -resize %i '%s' ; fi"% 
              (iconfile, iconpath, iconfile, iconpath, size, iconfile))
    return iconfile

    
def getdefaulticonfile(command):
    if command.startswith("Popup"):
        return geticonfile("gnome-fs-directory")
    else:
        return geticonfile("gnome-applications")    

def printmenu(name, icon, command):
    iconfile = geticonfile(icon) or getdefaulticonfile(command) or icon
    printtext('+ "%s%%%s%%" %s' % (name, iconfile, command))

def parsemenu(menu, name=""):
    if not name:
      name = menu.getPath()
    # print 'DestroyMenu "%s"' % name
    printtext('AddToMenu "%s"' % name)
    for entry in menu.getEntries():
	if isinstance(entry, xdg.Menu.Menu):
	    printmenu(entry.getName(), entry.getIcon(),
		      'Popup "%s"' % entry.getPath())
	elif isinstance(entry, xdg.Menu.MenuEntry):
	    desktop = DesktopEntry(entry.DesktopEntry.getFileName())
	    printmenu(desktop.getName(), desktop.getIcon(),
		      options.exec_command + " " + desktop.getExec())
	else:
	    printtext('# not supported: ' + str(entry))

    print
    for entry in menu.getEntries():
	if isinstance(entry, xdg.Menu.Menu):
	    parsemenu(entry)


for arg in args:
    print '# %s' % arg
    parsemenu(xdg.Menu.parse(arg), options.top)
        
