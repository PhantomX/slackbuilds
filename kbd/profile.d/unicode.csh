#!/bin/csh
# Unicode fixes

set consoletype=`/sbin/consoletype`

if ($?LANG) then
  switch ($LANG)
    case *.utf8*:
      case *.UTF-8*:
        if ( $?TERM ) then
          if ( "$TERM" == "linux" ) then
            if ( "$consoletype" == "vt" ) then
              switch ($LANG)
                case en_IN*:
                        breaksw
                case ja*:
                case ko*:
                case si*:
                case zh*:
                case *_IN*:
                        setenv LANG en_US.UTF-8
                        breaksw
              endsw
            endif
          endif
        endif
        breaksw
      case *:
        if ( $?TERM ) then
          if ( "$TERM" == "linux" ) then
            if ( "$consoletype" == "vt" ) then
              switch ($LANG)
                case en_IN*:
                        breaksw
                case ja*:
                case ko*:
                case si*:
                case zh*:
                case *_IN*:
                        setenv LANG en_US
                        breaksw
              endsw
            endif
          endif
        endif
        breaksw
  endsw
endif

unsetenv consoletype
