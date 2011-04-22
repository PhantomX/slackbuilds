
set(AUDIOFILES x-2sf.desktop
               x-ape.desktop
               x-bonk.desktop
               x-dsf.desktop
               x-gsf.desktop
               x-gym.desktop
               x-mac.desktop
               x-nsf.desktop
               x-pac.desktop
               x-psf.desktop
               x-qsf.desktop
               x-spc.desktop
               x-ssf.desktop
               x-tta.desktop
               x-usf.desktop
               x-wavpack-correction.desktop
               x-wavpack.desktop )

install(FILES ${AUDIOFILES} DESTINATION "${MIMELNK_INSTALL_DIR}/audio" )
