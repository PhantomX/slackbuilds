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
	msg_insertPasswd_title="Insert password"
	msg_insertPasswd_usr="Please insert user password of document \"${baseFileName}\":"
	msg_insertPasswd_own="Please insert main password of document \"${baseFileName}\":"

	msg_inputPagesRange_title="Input pages range"
	#msg_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number.\n\nPlease input page range to convert from \"${baseFileName}\":"
	msg_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number. Please input page range to convert from \"${baseFileName}\":"

	msg_DPI_title="Resolution, in DPI"
	#msg_DPI="Conversion of \"${baseFileName}\".\nSet resolution in DPI (default is 150):"
	msg_DPI="Conversion of \"${baseFileName}\". Set resolution in DPI (default is 150):"

	msg_options_title="Preferences"
	msg_options="Select options for conversion of \"${baseFileName}\""
	msg_options_color="generate a color PPM file"
	msg_options_gray="generate a grayscale PGM file"
	msg_options_mono="generate a monochrome PBM file"

	msg_imagesRootName_title="Insert pictures prefix"
	#msg_imagesRootName="The images name will be made by a prefix (without spaces) followed by a progressive number\n(${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...).\n\nChange prefix for images or leave default value:"
	msg_imagesRootName="The images name will be made by a prefix (without spaces) followed by a progressive number (${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...). Change prefix for images or leave default value:"

	msg_finish_title="Conversion of all pages the document \"${baseFileName}\":"
	msg_selected_finish_title="Conversion of selected pages of document \"${baseFileName}\":"
	msg_finish="Done."
}

load_language_it () {
	msg_insertPasswd_title="Inserisci password"
	msg_insertPasswd_usr="Per favore digita la password utente per \"${baseFileName}\":"
	msg_insertPasswd_own="Per favore digita la password principale per \"${baseFileName}\":"

	msg_inputPagesRange_title="Selezione range:"
	#msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico.\n\nPer favore inserisci il range di pagine da convertire da \"${baseFileName}\":"
	msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico. Per favore inserisci il range di pagine da convertire da \"${baseFileName}\":"

	msg_DPI_title="Risoluzione, in DPI"
	#msg_DPI="Conversione di \"${baseFileName}\".\nImposta la risoluzione in DPI (150 é il valore predefinito):"
	msg_DPI="Conversione di \"${baseFileName}\". Imposta la risoluzione in DPI (150 é il valore predefinito):"

	msg_options_title="Preferenze"
	msg_options="Seleziona le opzioni per la conversione di \"${baseFileName}\""
	msg_options_color="genera un file immagine PPM a colori"
	msg_options_gray="generate un file immagine PGM in scala di grigi"
	msg_options_mono="genera un file immagine PBM monocromatico"

	msg_imagesRootName_title="Inserisci il prefisso per le immagini"
	#msg_imagesRootName="Il nome delle immagini, sará composto da un prefisso (senza spazi) seguito da un numero crescente\n(${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...).\n\nCambia il prefisso per le immagini o lascia il valore predefinito:"
	msg_imagesRootName="Il nome delle immagini, sará composto da un prefisso (senza spazi) seguito da un numero crescente (${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...). Cambia il prefisso per le immagini o lascia il valore predefinito:"

	msg_finish_title="Conversione di tutte le pagine del documento \"${baseFileName}\":"
	msg_selected_finish_title="Conversione delle pagine selezionate del documento \"${baseFileName}\":"
	msg_finish="Conclusa."
}

################################################

all () {
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm ${options} ${dpi} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" | grep '^.' |sed 's/^/-opw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm "${usr_passwd}" ${options} ${dpi} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" | grep '^.' |sed 's/^/-opw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm "${own_passwd}" ${options} ${dpi} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

selected () {
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm ${options} ${dpi} ${range} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" | grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm "${usr_passwd}" ${options} ${dpi} ${range} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" | grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --radiolist "${msg_options}" _color "${msg_options_color}" on _gray "${msg_options_gray}" off _mono "${msg_options_mono}" off --separate-output | sed 's/_color//' | sed 'y/_/-/'`
	dpi=`kdialog --title "${msg_DPI_title}" --caption "${msg_DPI_title}" --icon editcopy --inputbox "${msg_DPI}" "150" | grep [0-9] | grep -v [^0-9] | sed 's/^/-r /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdftoppm "${own_passwd}" ${options} ${dpi} ${range} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
