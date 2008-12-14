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
	msg_options_1="Don't embed Type 1 fonts"
	msg_options_2="Don't embed TrueType fonts"
	msg_options_3="Don't embed CID PostScript fonts"
	msg_options_4="Don't embed CID TrueType fonts"
	msg_options_5="Expand pages smaller than the paper size"
	msg_options_6="Don't shrink pages larger than the paper size"
	msg_options_7="Don't center pages smaller than the paper size"
	msg_options_8="Enable duplex printing"

	msg_level_options_title="Postscript level"
	msg_level_options="Select PostScript level to generate"
	msg_level_options_1="Level 1 PostScript"
	msg_level_options_2="Level 2 PostScript (default)"
	msg_level_options_3="Level 3 PostScript"
	msg_level_options_1sep="Level 1 separable PostScript"
	msg_level_options_2sep="Level 2 separable PostScript"
	msg_level_options_3sep="Level 3 separable PostScript"

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
	msg_options_1="Non incorporare i caratteri Type 1"
	msg_options_2="Non incorporare i caratteri TrueType"
	msg_options_3="Non incorporare i caratteri CID PostScript"
	msg_options_4="Non incorporare i caratteri CID TrueType"
	msg_options_5="Espandi le pagine piccole"
	msg_options_6="Non ridurre le pagine grandi"
	msg_options_7="Non centrare le pagine piccole"
	msg_options_8="Abilita stampa duplex"

	msg_level_options_title="Livello Postscript"
	msg_level_options="Seleziona il livello PostScript da generare"
	msg_level_options_1="PostScript livello 1"
	msg_level_options_2="PostScript livello 2 (predefinito)"
	msg_level_options_3="PostScript livello 3"
	msg_level_options_1sep="PostScript livello 1 separabile"
	msg_level_options_2sep="PostScript livello 2 separabile"
	msg_level_options_3sep="PostScript livello 3 separabile"

	msg_saveFile_title="Salva documento"

	msg_all_finish_title="Conversione di tutte le pagine del documento \"${baseFileName}\""
	msg_selected_finish_title="Conversione delle pagine selezionate del documento \"${baseFileName}\""
	msg_finish="Conclusa."
}

################################################

all () {
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} "${@}" "${psFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

all_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} "${usr_passwd}" "${@}" "${psFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

all_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} "${own_passwd}" "${@}" "${psFileName}" && \
	kdialog --title "${msg_all_finish_title}" --passivepopup "${msg_finish}" 5
}

selected () {
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} ${range} "${@}" "${psFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_usr () {
	usr_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon encrypted --password "${msg_insertPasswd_usr}" |grep '^.' |sed 's/^/-upw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} "${usr_passwd}" ${range} "${@}" "${psFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

selected_own () {
	own_passwd=`kdialog --title "${msg_insertPasswd_title}" --caption "${msg_insertPasswd_title}" --icon decrypted --password "${msg_insertPasswd_own}" |grep '^.' |sed 's/^/-opw /'`
	range=`kdialog --title "${msg_inputPagesRange_title}" --caption "${msg_inputPagesRange_title}" --icon editcopy --inputbox "${msg_inputPagesRange}" "1-end"`
	range=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/-end//' | sed 's/\(^[0-9][0-9]*\)/-f \1/' | sed 's/\(^-f [0-9][0-9]*\)-\([0-9][0-9]*\)/\1 -l \2/'| sed 's/^-\([0-9][0-9]*\)/-l \1/'`
	options=`kdialog --title "${msg_options_title}" --caption "${msg_options_title}" --icon encrypted --checklist "${msg_options}" _noembt1 "${msg_options_1}" off _noembtt "${msg_options_2}" off _noembcidps "${msg_options_3}" off _noembcidtt "${msg_options_4}" off _expand "${msg_options_5}" on _noshrink "${msg_options_6}" off _nocenter "${msg_options_7}" off _duplex "${msg_options_8}" off --separate-output | sed 'y/_/-/'`
	level_options=`kdialog --title "${msg_level_options_title}" --caption "${msg_level_options_title}" --icon encrypted --radiolist "${msg_level_options}" _level1 "${msg_level_options_1}" off _level2 "${msg_level_options_2}" on _level3 "${msg_level_options_3}" off _level1sep "${msg_level_options_1sep}" off _level2sep "${msg_level_options_2sep}" off _level3sep "${msg_level_options_3sep}" off --separate-output | sed 'y/_/-/'`
	psFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName}.ps" application/postscript`
	pdftops ${level_options} ${options} "${own_passwd}" ${range} "${@}" "${psFileName}" && \
	kdialog --title "${msg_selected_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
