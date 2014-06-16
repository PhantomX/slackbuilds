#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="https://bitbucket.org/multicoreware/${module}"

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
  hg clone ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] && [ -z "${snaptag}" ] ; then
      hgdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      hg checkout -d "${hgdate}"
    fi

    # Extracted from source/cmake/version.cmake
    HG_REVISION_TAG="$(hg log -r. --template '{latesttag}')"
    HG_REVISION_DIST="$(hg log -r. --template '{latesttagdistance}')"
    HG_REVISION_ID="$(hg log -r. --template '{node|short}')"

    if [ -z "${HG_REVISION_TAG}" ] ;then
      HG_REVISION_ID="hg-tip"
    else
      if [ "${HG_REVISION_TAG}" == "null" ] ;then
        HG_REVISION_TAG="trunk"
      elif echo "${HG_REVISION_TAG}" | grep -q '^r' ;then
        HG_REVISION_TAG=${HG_REVISION_TAG#r}
      fi
      X265_LATEST_TAG=${HG_REVISION_TAG}
      if [ "${HG_REVISION_DIST}" -eq "0" ] ;then
        HG_REVISION=${HG_REVISION_TAG}
      else
        HG_REVISION="${HG_REVISION_TAG}+${HG_REVISION_DIST}-${HG_REVISION_ID}"
      fi
    fi

    sed -i \
      -e "/^set\(X265_VERSION/s|\"unknown\"|\"${HG_REVISION}\"|g" \
      -e "/^set\(X265_LATEST_TAG/s|\"0\.0\"|\"${X265_LATEST_TAG}\"|g" \
      source/cmake/version.cmake

    find . -type d -name .hg -print0 | xargs -0r rm -rf
    rm -f .hgignore .hgsigs .hgtags .hg_archival.txt
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
