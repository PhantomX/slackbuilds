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
	msg_custom_title="Custom \"N-upped\" of \"${baseFileName}\""
	msg_custom="Set new proportions for \"${baseFileName}\" (columns X row):"
	msg_frames_title="Frames preference for \"${baseFileName}\""
	msg_frames="Do you want frames for every pages of \"${baseFileName}\"?"
	msg_frames_no="No"
	msg_frames_yes="Yes"
	msg_saveFile_title="Save document"
	msg_finish_title="Conversion of document \"${baseFileName}\""
	msg_finish="Done."
}

load_language_fr () {
	msg_custom_title="Conversion personalisée du \"${baseFileName}\""
	msg_custom="Proportions (colonnes X lignes):"
	msg_frames_title="Bordures du \"${baseFileName}\""
	msg_frames="Voulez-vous les bordures pour chaques page ?"
	msg_frames_no="Non"
	msg_frames_yes="Oui"
	msg_saveFile_title="Enregistrer le document sous"
	msg_finish_title="Conversion le document \"${baseFileName}\""
	msg_finish="Terminé."
}

load_language_it () {
	msg_custom_title="Rimpaginazione personalizzata di \"${baseFileName}\""
	msg_custom="Imposta le nuove proporzioni per \"${baseFileName}\" (colonne X righe):"
	msg_frames_title="Preferenza bordi per \"${baseFileName}\""
	msg_frames="Vuoi i bordi per ogni attuale pagina di \"${baseFileName}\"?"
	msg_frames_no="No"
	msg_frames_yes="Si"
	msg_saveFile_title="Salva documento"
	msg_finish_title="Rimpaginazione del documento \"${baseFileName}\""
	msg_finish="Conclusa."
}

load_language_sr () {
	msg_custom_title="Персонализована конверзија документа"
	msg_custom="Пропорције (врсте X редови):"
	msg_frames_title="Оквири"
	msg_frames="Да ли желите оквире за све странице?"
	msg_frames_no="Не"
	msg_frames_yes="Да"
	msg_saveFile_title="Сачувајте документ"
	msg_finish_title="Конверзија документа \"${baseFileName}\""
	msg_finish="Готова."
}

load_language_srLatn () {
	msg_custom_title="Personalizovana konverzija dokumenta"
	msg_custom="Proporcije (vrste X redovi):"
	msg_frames_title="Okviri"
	msg_frames="Da li želite okvire za sve stranice?"
	msg_frames_no="Ne"
	msg_frames_yes="Da"
	msg_saveFile_title="Sačuvajte dokument"
	msg_finish_title="Konverzija dokumenta \"${baseFileName}\""
	msg_finish="Gotova."
}

load_language_pt () {
	msg_custom_title="Conversão personalizada do \"${baseFileName}\""
	msg_custom="Proporção (colunas X linhas):"
	msg_frames_title="Molduras do \"${baseFileName}\""
	msg_frames="Deseja adicionar molduras a todas as páginas?"
	msg_frames_no="Não"
	msg_frames_yes="Sim"
	msg_saveFile_title="Guardar ficheiro"
	msg_finish_title="Converter o documento \"${baseFileName}\""
	msg_finish="Concluído."
}

################################################

nup_2x1 () {
	frame="--frame `kdialog --title "${msg_frames_title}" --caption "${msg_frames_title}" --icon view_icon --radiolist "${msg_frames}" false "${msg_frames_no}" on true "${msg_frames_yes}" off`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName} (2x1).pdf" application/pdf`"
	pdfnup "${@}" --nup 2x1 ${frame} --outfile "${outputFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

nup_2x2 () {
	frame="--frame `kdialog --title "${msg_frames_title}" --caption "${msg_frames_title}" --icon view_icon --radiolist "${msg_frames}" false "${msg_frames_no}" on true "${msg_frames_yes}" off`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName} (2x2).pdf" application/pdf`"
	pdfnup "${@}" --nup 2x2 ${frame} --outfile "${outputFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

nup_2x3 () {
	frame="--frame `kdialog --title "${msg_frames_title}" --caption "${msg_frames_title}" --icon view_icon --radiolist "${msg_frames}" false "${msg_frames_no}" on true "${msg_frames_yes}" off`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName} (2x3).pdf" application/pdf`"
	pdfnup "${@}" --nup 2x3 ${frame} --outfile "${outputFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

nup_2x4 () {
	frame="--frame `kdialog --title "${msg_frames_title}" --caption "${msg_frames_title}" --icon view_icon --radiolist "${msg_frames}" false "${msg_frames_no}" on true "${msg_frames_yes}" off`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName} (2x4).pdf" application/pdf`"
	pdfnup "${@}" --nup 2x4 ${frame} --outfile "${outputFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

nup_custom () {
	nup="`kdialog --title "${msg_custom_title}" --caption "${msg_custom_title}" --icon view_icon --inputbox "${msg_custom}" "1x1"`"
	frame=`kdialog --title "${msg_frames_title}" --caption "${msg_frames_title}" --icon view_icon --radiolist "${msg_frames}" false "${msg_frames_no}" on true "${msg_frames_yes}" off`
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon view_icon --getsavefilename "${workDir}/${baseFileName} (${nup}).pdf" application/pdf`"
	pdfnup "${@}" --nup ${nup} --frame ${frame} --outfile "${outputFileName}" && \
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
