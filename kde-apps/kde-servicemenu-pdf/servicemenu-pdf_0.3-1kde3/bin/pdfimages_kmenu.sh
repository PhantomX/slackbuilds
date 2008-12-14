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
	#msg_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number.\n\nPlease input page range of \"${baseFileName}\" to extract images:"
	msg_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number. Please input page range of \"${baseFileName}\" to extract images:"

	msg_imagesRootName_title="Insert pictures prefix"
	#msg_imagesRootName="Notes: The images name, once extracted from the document, will be made by a prefix followed by a progressive number:\n(${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...).\n\nChange prefix for images or leave default value:"
	msg_imagesRootName="Notes: The images name, once extracted from the document, will be made by a prefix followed by a progressive number: (${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...). Change prefix for images or leave default value:"

	msg_finish_title="Extraction images from all pages of document \"${baseFileName}\""
	msg_finish_title_selected="Extraction images from selected pages of document \"${baseFileName}\""
	msg_finish="Done."
}

load_language_it () {
	msg_insertPasswd_title="Inserisci Password"
	msg_insertPasswd_usr="Per favore digita la password utente di \"${baseFileName}\":"
	msg_insertPasswd_own="Per favore digita la password principale di \"${baseFileName}\":"

	msg_inputPagesRange_title="Seleziona range:"
	#msg_inputPagesRange="Note: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico.\n\nPer favore inserisci il range di pagine di \"${baseFileName}\" da cui estrarre le immagini:"
	msg_inputPagesRange="Note: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico. Per favore inserisci il range di pagine di \"${baseFileName}\" da cui estrarre le immagini:"

	msg_imagesRootName_title="Inserisci il prefisso per le immagini"
	#msg_imagesRootName="Note: Il nome delle immagini, una votla estratte dal documento, sará composto da un prefisso seguito da un numero crescente (${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...).\n\nCambia il prefisso per le immagini o lascia il valore predefinito:"
	msg_imagesRootName="Note: Il nome delle immagini, una votla estratte dal documento, sará composto da un prefisso seguito da un numero crescente (${baseFileName}-000.ppm, ${baseFileName}-001.ppm ...). Cambia il prefisso per le immagini o lascia il valore predefinito:"

	msg_finish_title="Estrazione delle immagini da tutte le pagine del documento \"${baseFileName}\""
	msg_finish_title_selected="Estrazione delle immagini dalle pagine selezionate del documento \"${baseFileName}\""
	msg_finish="Completata."
}

################################################

all () {
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j "${usr_passwd}" "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j "${own_passwd}" "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

selected () {
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j ${range} "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title_selected}" --passivepopup "${msg_finish}" 5
}

selected_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j ${range} "${usr_passwd}" "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title_selected}" --passivepopup "${msg_finish}" 5
}

selected_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	imagesRootName=`kdialog --title "${msg_imagesRootName_title}" --caption "${msg_imagesRootName_title}" --icon editcopy --inputbox "${msg_imagesRootName}" "${baseFileName}"`
	pdfimages -j ${range} "${own_passwd}" "${@}" "${imagesRootName}" && \
	kdialog --title "${msg_finish_title_selected}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
