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
	msg_options_layout="Maintain the  original physical layout"
	msg_options_html="Generate a simple HTML file"
	msg_options_NoBreaks="Don’t insert page breaks (all in one page)"

	msg_saveFile_title="Save document"

	msg_finish_title="Conversion of all pages the document \"${baseFileName}\""
	msg_selected_finish_title="Conversion of selected pages of document \"${baseFileName}\""
	msg_finish="Done."
}

load_language_it () {
	msg_insertPasswd_title="Inserisci Password"
	msg_insertPasswd_usr="Per favore digita la password utente di \"${baseFileName}\":"
	msg_insertPasswd_own="Per favore digita la password principale di \"${baseFileName}\":"

	msg_inputPagesRange_title="Selezione range:"
	#msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico.\n\nPer favore inserisci il range di pagine da convertire in testo da \"${baseFileName}\":"
	msg_inputPagesRange="Nota: La parola chiave \"end\" può essere usata per indicare la pagina finale di un documento al posto di un valore numerico. Per favore inserisci il range di pagine da convertire in testo da \"${baseFileName}\":"

	msg_options_title="Preferenze"
	msg_options="Seleziona le opzioni per la conversione di \"${baseFileName}\""
	msg_options_layout="Mantiene aspetto originale"
	msg_options_html="Genera un file html semplice"
	msg_options_NoBreaks="Non inserisce interruzioni di pagina (all in one page)"

	msg_saveFile_title="Salva documento"

	msg_finish_title="Conversione di tutte le pagine del documento \"${baseFileName}\""
	msg_selected_finish_title="Conversione delle pagine selezionate del documento \"${baseFileName}\""
	msg_finish="Conclusa."
}

################################################

all () {
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext ${options} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext "${usr_passwd}" ${options} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

all_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext "${own_passwd}" ${options} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

selected () {
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext ${options} ${range} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext "${usr_passwd}" ${options} ${range} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _layout "${msg_options_layout}" on _htmlmeta "${msg_options_html}" off _nopgbrk "${msg_options_NoBreaks}" off --separate-output | sed 'y/_/-/'`
	txtFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}" text/plain`
	pdftotext "${own_passwd}" ${options} ${range} "${@}" "${txtFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
