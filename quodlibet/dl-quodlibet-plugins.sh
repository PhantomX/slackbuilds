#!/bin/bash

curdir=$(pwd)

pushd /var/tmp

#
# Set up directory structure
#

mkdir quodlibet-plugins-$$

pushd quodlibet-plugins-$$

#
# download plugins from Quod Libet SVN
#
plugin_revision=3996
plugin_url="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/"

svn -q export -r$plugin_revision $plugin_url

# get rid of some plugins that we don't have dependencies for
#rm plugins/songsmenu/brainz.py
#rm plugins/events/lastfmsubmit.py

# don't know where this one went
#curl -o plugins/songsmenu/shell.2.py "http://www.sacredchao.net/quodlibet/attachment/wiki/Plugins/OpenInShell/shell.2.py?format=raw"

# get rid of any shebang lines

for plugin in `find plugins -name \*.py`
do
  sed -e '/^#!/,1d' $plugin > $plugin.tmp
  mv $plugin.tmp $plugin
done

tar cjf $curdir/quodlibet-plugins.tar.bz2 plugins

popd

rm -rf quodlibet-plugins-$$

popd
