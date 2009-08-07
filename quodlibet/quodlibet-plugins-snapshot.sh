#!/bin/bash

set -e

module=quodlibet-plugins
snaproot="https://quodlibet.googlecode.com/hg"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}
snap2=${snap/quodlibet-/}

pushd "${tmp}"
  hg clone -r ${snap} ${snaproot} ${module}-${snap2}
  pushd ${module}-${snap2}
  # get rid of some plugins that we don't have dependencies for
  rm -f plugins/songsmenu/brainz.py
  rm -f plugins/events/lastfmsubmit.py
  # get rid of any shebang lines
  for plugin in $(find plugins -name \*.py)
  do
    sed -e '/^#!/,1d' ${plugin} > ${plugin}.tmp
    mv ${plugin}.tmp ${plugin}
  done
  tar -Jcf "${pwd}"/${module}-${snap2}.tar.xz plugins
popd >/dev/null
