#!/bin/bash

function runCompiz() {
	gtk-window-decorator &
	exec compiz ccp $@
}

ISSW=`glxinfo | grep "Software Rasterizer" -c`

# Try with direct rendering
HAVETFP=`glxinfo | grep texture_from_pixmap -c`

if ( [ $ISSW == 0 ] && [ $HAVETFP -gt 2 ] ); then 
	runCompiz $@
fi

# Try again with indirect rendering
export LIBGL_ALWAYS_INDIRECT=1

HAVETFP=`glxinfo | grep texture_from_pixmap -c`

if ( [ $ISSW == 0 ] && [ $HAVETFP -gt 2 ] ); then 
	runCompiz $@
fi

# Fall back to metacity
exec metacity $@
