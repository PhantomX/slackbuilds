#!/bin/sh

SDMKUNDATA=/usr/share/sdmkun
SDMKUNHOME=${HOME}/.sdmkun

mkdir -p ~/.sdmkun
cd ~/.sdmkun || exit 1
cleanlinks
mkdir -p bmp bosses.d data fonts inspection model replay save shots user

shopt -s nullglob

[[ -e ./sdmkun ]] || ln -sf "/usr/libexec/sdmkun" ./sdmkun >& /dev/null

if [[ -d "${SDMKUNDATA}" ]] ; then

  if [[ -d "${SDMKUNDATA}/bmp" ]] ; then
    for bmp in $(find "${SDMKUNDATA}/bmp"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "bmp/${bmp}" ]] ; then 
        ln -s "${SDMKUNDATA}/bmp/${bmp}" "bmp/${bmp}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/bosses.d" ]] ; then
    for bosses in $(find "${SDMKUNDATA}/bosses.d"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "bosses.d/${bosses}" ]] ; then 
        ln -s "${SDMKUNDATA}/bosses.d/${bosses}" "bosses.d/${bosses}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/data" ]] ; then
    for data in $(find "${SDMKUNDATA}/data"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "data/${data}" ]] ; then 
        ln -s "${SDMKUNDATA}/data/${data}" "data/${data}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/fonts" ]] ; then
    for data in $(find "${SDMKUNDATA}/fonts"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "fonts/${fonts}" ]] ; then 
        ln -s "${SDMKUNDATA}/fonts/${fonts}" "fonts/${fonts}"
      fi
    done
  fi
  if [[ -d "${SDMKUNDATA}/inspection" ]] ; then
    for data in $(find "${SDMKUNDATA}/inspection"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "inspection/${inspection}" ]] ; then 
        ln -s "${SDMKUNDATA}/inspection/${inspection}" "inspection/${inspection}"
      fi
    done
  fi
  if [[ -d "${SDMKUNDATA}/model" ]] ; then
    for data in $(find "${SDMKUNDATA}/model"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "model/${model}" ]] ; then 
        ln -s "${SDMKUNDATA}/model/${model}" "model/${model}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/save" ]] ; then
    for data in $(find "${SDMKUNDATA}/save"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "save/${save}" ]] ; then 
        cp "${SDMKUNDATA}/save/${save}" "save/${save}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/shots" ]] ; then
    for data in $(find "${SDMKUNDATA}/shots"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "shots/${shots}" ]] ; then 
        ln -s "${SDMKUNDATA}/shots/${shots}" "shots/${shots}"
      fi
    done
  fi

  if [[ -d "${SDMKUNDATA}/user" ]] ; then
    for data in $(find "${SDMKUNDATA}/user"  -maxdepth 1 -type f -printf '%f '); do 
      if [[ ! -e "user/${user}" ]] ; then 
        ln -s "${SDMKUNDATA}/user/${user}" "user/${user}"
      fi
    done
  fi

fi

# execute program (with args)
exec ./sdmkun "$@"
