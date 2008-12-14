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

	msg_options_title="Preferences"
	msg_options="Select options for conversion of \"${baseFileName}\""
	msg_options_ReplaceLinks="Excange .pdf links with .html"
	msg_options_NoImages="Ignore images"
	msg_options_NoFrames="Generate no frames (all in one page)"
	msg_options_ForceHiddenText="Force hidden text extraction"
	msg_options_NoMerge="Do not merge paragraphs"
	msg_options_NoDRM="Override document DRM (Digital Restrictions Management) setting"

	msg_saveFile_title="Save document"

	msg_all_finish_title="Conversion of all pages the document \"${baseFileName}\""
	msg_selected_finish_title="Conversion of selected pages of document \"${baseFileName}\""
	msg_finish="Done."
}

load_language_it () {
	msg_insertPasswd_title="Inserisci password"
	msg_insertPasswd_usr="Per favore digita la password utente per \"${baseFileName}\":"
	msg_insertPasswd_own="Per favore digita la password principale \"${baseFileName}\":"

	msg_inputPagesRange_title="Selezione range"
	#msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico.\n\nPer favore inserisci il range di pagine da estrarre da \"${baseFileName}\":"
	msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico. Per favore inserisci il range di pagine da estrarre da \"${baseFileName}\":"

	msg_options_title="Preferenze"
	msg_options="Seleziona le opzioni per la conversione di \"${baseFileName}\""
	msg_options_ReplaceLinks="Sostituisci i collegamenti .pdf con .html"
	msg_options_NoImages="Ignora le immagini"
	msg_options_NoFrames="Non generare frames (tutto in una pagina)"
	msg_options_ForceHiddenText="Forza l'estrazione del testo nascosto"
	msg_options_NoMerge="Non unire i paragrafi"
	msg_options_NoDRM="Ignora le impostazioni DRM (Digital Restrictions Management)"

	msg_saveFile_title="Salva documento"

	msg_all_finish_title="Conversione di tutte le pagine del documento \"${baseFileName}\""
	msg_selected_finish_title="Conversione delle pagine selezionate del documento \"${baseFileName}\""
	msg_finish="Conclusa."
}

################################################

all () {
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

all_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} "${usr_passwd}" "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

all_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} "${own_passwd}" "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

selected () {
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} ${range} "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} "${usr_passwd}" ${range} "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _p "${msg_options_ReplaceLinks}" on _i "${msg_options_NoImages}" off _noframes "${msg_options_NoFrames}" on _hidden "${msg_options_ForceHiddenText}" off _nomerge "${msg_options_NoMerge}" off _nodrm "${msg_options_NoDRM}" on --separate-output | sed 'y/_/-/'`
	htmlFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.html" text/html`
	pdftohtml ${options} "${own_passwd}" ${range} "${@}" "${htmlFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
