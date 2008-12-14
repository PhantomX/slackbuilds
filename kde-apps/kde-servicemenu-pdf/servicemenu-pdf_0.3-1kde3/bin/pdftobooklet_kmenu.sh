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
totalPages=`pdftk "${@}" dump_data | grep "NumberOfPages" | cut -d" " -f 2-`

## This is minimal content of empty pdf file.
emptyPDF='%PDF-1.4
5 0 obj <</Length 6 0 R/Filter /FlateDecode>> endobj
4 0 obj <</Type/Page/MediaBox [0 0 612 792] /Parent 3 0 R /Resources<</ProcSet[/PDF] >> /Contents 5 0 R >> endobj
3 0 obj << /Type /Pages /Kids [4 0 R] /Count 1 >> endobj
1 0 obj <</Type /Catalog /Pages 3 0 R /Metadata 7 0 R >> endobj
7 0 obj <</Type/Metadata /Subtype/XML/Length 1287>>stream endstream endobj
xref
0 8
trailer
<< /Size 8 /Root 1 0 R /Info 2 0 R >>
startxref
%%EOF'

#### languages strings messages #################
# Sintax for strings name is: msg_[$action]_$window_[$section]
# For languages as sr@Latn use srLatn

load_language_en () {
	msg_pagesPerBooklet_title="Document \"${baseFileName}\""
	msg_pagesPerBooklet="Pages per booklet (Total pages: $totalPages)"
	msg_orientation_title="Document \"${baseFileName}\""
	msg_orientation_text="Select orientation of document \"${baseFileName}\""
	msg_orientation_leftToRight="The document is in left-to-right language"
	msg_orientation_rightToLeft="The document is in right-to-left language (such as Arabic or Hebrew)"
	msg_oneFile="Do you want all booklet in only one file?"
	msg_oneFile_outputFileName="${baseFileName} (booklet)"
	msg_saveFile_title="Save document"
	msg_progressbarDialog_title="Document \"${baseFileName}\""
	msg_progressbarDialog_text="Converting document \"${baseFileName}\" to booklet"
	msg_progressbarDialog_text2="Converting pages ... "
	msg_progressbarDialog_saving="Saving booklet N."
	msg_progressbarDialog_saving2="Saving booklet ..."
	msg_finish_title="Conversion of document \"${baseFileName}\""
	msg_finish="Done."
}

load_language_it () {
	msg_pagesPerBooklet_title="Documento \"${baseFileName}\""
	msg_pagesPerBooklet="Pagine per opuscolo (Pagine totali: $totalPages)"
	msg_orientation_title="Documento \"${baseFileName}\""
	msg_orientation_text="Seleziona l'orientazione del documento \"${baseFileName}\""
	msg_orientation_leftToRight="Lingua da sinistra a destra (come inglese o italiano)"
	msg_orientation_rightToLeft="Lingua da destra a sinistra (come arabo o ebraico)"
	msg_oneFile="Vuoi salvare gli opuscoli in un solo file?"
	msg_oneFile_outputFileName="${baseFileName} (opuscolo)"
	msg_saveFile_title="Salva documento"
	msg_progressbarDialog_title="Documento \"${baseFileName}\""
	msg_progressbarDialog_text="Conversione del documento \"${baseFileName}\" in opuscolo"
	msg_progressbarDialog_text2="Conversione delle pagine ..."
	msg_progressbarDialog_saving="Salvataggio dell'opuscolo N."
	msg_progressbarDialog_saving2="Salvataggio dell'opuscolo ..."
	msg_finish_title="Conversione del documento \"${baseFileName}\""
	msg_finish="Completata."
}

################################################

all () {
	pagesPerBooklet=`kdialog --caption "${msg_pagesPerBooklet_title}" --icon kjournal --combobox "${msg_pagesPerBooklet}" $(seq 4 4 $((totalPages*2+2)))`;
	if [ x"$pagesPerBooklet" = x ]; then exit 0; fi

	case "`kdialog --caption "${msg_orientation_title}" --icon kjournal --radiolist "${msg_orientation_text}" 1 "${msg_orientation_leftToRight}" on 0 "${msg_orientation_rightToLeft}" off --geometry 350x150`" in
		0) rightToLeft="TRUE";;
		1) rightToLeft="FALSE";;
		*) exit 0;;
	esac

	## if necessary, add empty pages to document
	empty_pages_to_add=$((pagesPerBooklet - (totalPages % pagesPerBooklet)))
	if [ $empty_pages_to_add -eq 0 ];
		then workFile="${@}"
		else string=""
			echo "${emptyPDF}" > "~empty.pdf"
			for i in $(seq $empty_pages_to_add); do
				string="${string} ~empty.pdf"
			done
			workFile="${workDir}/~${baseFileName}.pdf"
			pdftk "${@}" ${string} cat output "${workFile}"
			rm "${workDir}/~empty.pdf"
			totalPages=$((totalPages + empty_pages_to_add))
	fi

	kdialog --yesno "${msg_oneFile}"
	case "$?" in
		0) oneFile="TRUE";
			outputFileName=`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon kjournal --getsavefilename "${workDir}/${msg_oneFile_outputFileName}.pdf" application/pdf`;
			if [ x"${outputFileName}" = x ]; then exit 0; fi;;
		1) oneFile="FALSE";;
		*) exit 0;;
	esac

	n='0'; startPage='0'; string=''
	progressbarDialog=`kdialog -title "${msg_progressbarDialog_title}" --icon kjournal --progressbar "${msg_progressbarDialog_text}" $totalPages`
	#qdbus $progressbarDialog org.kde.kdialog.ProgressDialog.showCancelButton true
	#until test "true" = `qdbus $progressbarDialog wasCancelled`; do
		while [ "$(($startPage+$pagesPerBooklet))" -le "$totalPages" ]; do
			a=$(($startPage+1))
			b=$(($startPage+$pagesPerBooklet))
			while [ "$a" -lt "$b" ]; do
				if [ x"$rightToLeft" = x'FALSE' ];
					then string="${string},${b},${a},$((a+1)),$((b-1))";
					else string="${string},${a},${b},$((b-1)),$((a+1))";
				fi
				a=$((a+2))
				b=$((b-2))
				qdbus $progressbarDialog org.kde.kdialog.ProgressDialog.setLabelText "${msg_progressbarDialog_saving} $(($startPage+1))-$(($startPage+$pagesPerBooklet))"
				qdbus $progressbarDialog Set org.kde.kdialog.ProgressDialog value $a
			done
			if [ x"$oneFile" = x'FALSE' ];
				then qdbus $progressbarDialog org.kde.kdialog.ProgressDialog.setLabelText "${msg_progressbarDialog_saving} ${n} ..."
					n=$((n+1))
					pdfnup "${workFile}" --pages "${string#,}" --outfile "${msg_oneFile_outputFileName} ($(($startPage+1))-$(($startPage+$pagesPerBooklet))).pdf";
					string=''
					sleep 1
			fi
			startPage=$(($startPage+$pagesPerBooklet))
		done
		if [ x"$oneFile" = x'TRUE' ];
			then qdbus $progressbarDialog org.kde.kdialog.ProgressDialog.setLabelText "${msg_progressbarDialog_saving2}"
				pdfnup "${workFile}" --pages "${string#,}" --outfile "${outputFileName}"
		fi
	#done
	qdbus $progressbarDialog org.kde.kdialog.ProgressDialog.close
	rm "${workFile}"
	kdialog --title "${msg_finish_title}" --passivepopup "${msg_finish}" 5
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
