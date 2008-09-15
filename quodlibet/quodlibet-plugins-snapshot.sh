#!/bin/bash

set -e

module=quodlibet
snaproot="http://svn.sacredchao.net/svn/${module}/trunk/plugins/"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

pushd "${tmp}"
  svn -q export -r${snap} ${snaproot}
  # get rid of any shebang lines
  for plugin in $(find plugins -name \*.py)
  do
    sed -e '/^#!/,1d' ${plugin} > ${plugin}.tmp
    mv ${plugin}.tmp ${plugin}
  done
  tar -jcf "${pwd}"/${module}-plugins-${snap}.tar.bz2 plugins
popd >/dev/null
