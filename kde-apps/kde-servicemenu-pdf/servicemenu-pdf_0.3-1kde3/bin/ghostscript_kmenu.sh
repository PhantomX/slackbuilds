#! /bin/sh
#
# 	Part of servicemenu-pdf Version 0.3
# 	Copyright (C) 2008 Giuseppe Benigno <giuseppe.benigno(at)egregorion.net>
#
# 	This program is free software: you can redistribute it and/or modify
# 	it under the terms of the GNU General Public License as published by
# 	the Free Software Foundation, either version 3 of the License, or
# 	(at your option) any later version.
#
# 	This program is distributed in the hope that it will be useful,
# 	but WITHOUT ANY WARRANTY; without even the implied warranty of
# 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# 	GNU General Public License for more details.
#
# 	You should have received a copy of the GNU General Public License
# 	along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

lang=`echo "${1}" | sed -e "s/@//g"`
shift
action="${1}"
shift
workDir="${1%/*}"; if [ ! -d "${workDir}" ]; then workDir="./"; fi
fileName="${1##*/}"
baseFileName="${fileName%.*}"

#### languages strings messages #################
# Sintax for strings name is: msg_[$action]_$window_[$section]
# For languages as sr@Latn use srLatn

load_language_en () {
	msg_optimize_initial_outputFileName="${workDir}/${baseFileName} (optimized).pdf"
	msg_optimize_saveFile_title="Save document"
	msg_optimize_finish_title="Optimization of document \"${baseFileName}\""
	msg_optimize_finish="Done."

	msg_png_destDir_16m="${workDir}/${baseFileName} (full color png)"
	msg_png_destDir_256="${workDir}/${baseFileName} (256 colors png)"
	msg_png_destDir_16="${workDir}/${baseFileName} (16 color png)"
	msg_png_destDir_gray="${workDir}/${baseFileName} (gray png)"
	msg_png_destDir_mono="${workDir}/${baseFileName} (mono png)"
	msg_png_destDir_alpha="${workDir}/${baseFileName} (transparency png)"
	msg_png_dpi_title="Input DPI for \"${baseFileName}\""
	msg_png_dpi_text="Please write DPI resolution for images. Normal screen have 72x72 DPI."
	msg_png_finish_title="Conversion of document \"${baseFileName}\""
	msg_png_finish="Done."

	msg_jpg_destDir_gray="${workDir}/${baseFileName} (gray jpeg)"
	msg_jpg_destDir_color="${workDir}/${baseFileName} (color jpeg)"
	msg_jpg_dpi_title="Input DPI for \"${baseFileName}\""
	msg_jpg_dpi_text="Please write DPI resolution for images. Normal screen have 72x72 DPI."
	msg_jpg_finish_title="Conversion of document \"${baseFileName}\""
	msg_jpg_finish="Done."

	msg_fax_destDir_tiffg3="${workDir}/${baseFileName} (G3 fax encoding)"
	msg_fax_destDir_tiffg32d="${workDir}/${baseFileName} (2-D G3 fax encoding)"
	msg_fax_destDir_tiffg4="${workDir}/${baseFileName} (G4 fax encoding)"
	msg_fax_finish_title="Conversion of document \"${baseFileName}\""
	msg_fax_finish="Done."
}

load_language_it () {
	msg_optimize_initial_outputFileName="${workDir}/${baseFileName} (ottimizzato).pdf"
	msg_optimize_saveFile_title="Salva documento"
	msg_optimize_finish_title="Ottimizzazione del documento \"${baseFileName}\""
	msg_optimize_finish="Conclusa."

	msg_png_destDir_16m="${workDir}/${baseFileName} (png con tutti i colori)"
	msg_png_destDir_256="${workDir}/${baseFileName} (png con 256 colori)"
	msg_png_destDir_16="${workDir}/${baseFileName} (png con 16 colori)"
	msg_png_destDir_gray="${workDir}/${baseFileName} (png toni di grigio)"
	msg_png_destDir_mono="${workDir}/${baseFileName} (png bianco e nero)"
	msg_png_destDir_alpha="${workDir}/${baseFileName} (png con trasparenza)"
	msg_png_dpi_title="Inserimento DPI per \"${baseFileName}\""
	msg_png_dpi_text="Per favore scrivi la risoluzione in DPI per le immagini. Gli schermi normali hanno una risoluzione di 72x72 DPI."
	msg_png_finish_title="Conversione del documento \"${baseFileName}\""
	msg_png_finish="Completata."

	msg_jpg_destDir_gray="${workDir}/${baseFileName} (jpeg in toni di grigio)"
	msg_jpg_destDir="${workDir}/${baseFileName} (jpeg a colori)"
	msg_jpg_dpi_title="Inserimento DPI per \"${baseFileName}\""
	msg_jpg_dpi_text="Per favore scrivi la risoluzione in DPI per le immagini. Gli schermi normali hanno una risoluzione di 72x72 DPI."
	msg_jpg_finish_title="Conversione del documento \"${baseFileName}\""
	msg_jpg_finish="Completata."

	msg_fax_destDir_tiffg3="${workDir}/${baseFileName} (codifica fax G3)"
	msg_fax_destDir_tiffg32d="${workDir}/${baseFileName} (codifica fax 2-D G3)"
	msg_fax_destDir_tiffg4="${workDir}/${baseFileName} (codifica fax G4)"
	msg_fax_finish_title="Conversione del documento \"${baseFileName}\""
	msg_fax_finish="Completata."
}

################################################

optimize () {
	outputFileName="`kdialog --title "${msg_optimize_saveFile_title}" --caption "${msg_optimize_saveFile_title}" --icon view_icon --getsavefilename "${msg_optimize_initial_outputFileName}" application/pdf`"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=pdfwrite -sOutputFile="${outputFileName}" "${1}" && \
	kdialog --title "${msg_optimize_finish_title}" --passivepopup "${msg_optimize_finish}" 5
}

################################################

#kdialog --radiolist "Colors of images" png16m "Full colors" on png256 "256 colors"off png16 "16 colors" off pnggray "Gray tones" off pngmono "mono (black and white)" pngalpha "With transparency" off

png16m () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_16m}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=png16m -r"${dpi}" -sOutputFile="${msg_png_destDir_16m}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

png256 () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_256}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=png256 -r"${dpi}" -sOutputFile="${msg_png_destDir_256}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

png16 () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_16}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=png16 -r"${dpi}" -sOutputFile="${msg_png_destDir_16}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

pnggray () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_gray}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=pnggray -r"${dpi}" -sOutputFile="${msg_png_destDir_gray}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

pngmono () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_mono}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=pngmono -r"${dpi}" -sOutputFile="${msg_png_destDir_mono}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

pngalpha () {
	dpi=`kdialog --title "${msg_png_dpi_title}" --caption "${msg_png_dpi_title}" --icon editcopy --inputbox "${msg_png_dpi_text}" "72x72"`
	mkdir -p "${msg_png_destDir_alpha}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=pngalpha -r"${dpi}" -sOutputFile="${msg_png_destDir_alpha}/page_%0d.png" "${1}" && \
	kdialog --title "${msg_png_finish_title}" --passivepopup "${msg_png_finish}" 5
}

################################################

jpeg_gray () {
	dpi=`kdialog --title "${msg_jpg_dpi_title}" --caption "${msg_jpg_dpi_title}" --icon editcopy --inputbox "${msg_jpg_dpi_text}" "72x72"`
	mkdir -p "${msg_jpg_destDir_gray}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxStripSize=8192 -sDEVICE=jpeggray -r"${dpi}" -sOutputFile="${msg_jpg_destDir_gray}/page_%0d.jpeg" "${1}" && \
	kdialog --title "${msg_jpg_finish_title}" --passivepopup "${msg_jpg_finish}" 5
}

jpeg () {
	dpi=`kdialog --title "${msg_jpg_dpi_title}" --caption "${msg_jpg_dpi_title}" --icon editcopy --inputbox "${msg_jpg_dpi_text}" "72x72"`
	mkdir -p "${msg_jpg_destDir}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxStripSize=8192 -sDEVICE=jpeg -r"${dpi}" -sOutputFile="${msg_jpg_destDir}/page_%0d.jpeg" "${1}" && \
	kdialog --title "${msg_jpg_finish_title}" --passivepopup "${msg_jpg_finish}" 5
}

################################################

tiffg3 () {
	mkdir -p "${msg_fax_destDir_tiffg3}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxStripSize=8192 -sDEVICE=tiffg3 -sOutputFile="${msg_fax_destDir_tiffg3}/page_%0d.tiff" "${1}" && \
	kdialog --title "${msg_fax_finish_title}" --passivepopup "${msg_fax_finish}" 5
}

tiffg32d () {
	mkdir -p "${msg_fax_destDir_tiffg32d}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxStripSize=8192 -sDEVICE=tiffg32d -sOutputFile="${msg_fax_destDir_tiffg32d}/page_%0d.tiff" "${1}" && \
	kdialog --title "${msg_fax_finish_title}" --passivepopup "${msg_fax_finish}" 5
}

tiffg4 () {
	mkdir -p "${msg_fax_destDir_tiffg4}"
	gs -dSAFER -dBATCH -dNOPAUSE -q -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dMaxStripSize=8192 -sDEVICE=tiffg4 -sOutputFile="${msg_fax_destDir_tiffg4}/page_%0d.tiff" "${1}" && \
	kdialog --title "${msg_fax_finish_title}" --passivepopup "${msg_fax_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
    "${action}" "${@}"
cd -
