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
baseFileName=`echo "${@}" | sed -e "s/ \//\n\//g" | sed -e "s/ /\ /g" | sed -e "s/.*\// /" | sed -e "s/[.]pdf$//" | tr "\n" "," | sed -e "s/^ \(.*\),[[:blank:]]*$/\1/"`

#### languages strings messages #################
# Sintax for strings name is: msg_[$action]_$window_[$section]
# For languages as sr@Latn use srLatn

load_language_en () {
	msg_saveFile_title="Save file ..."

	#msg_join_oneFileOnly="Can't join one file only.\nPlease select not less than two files."
	msg_join_oneFileOnly="Can't join one file only. Please select not less than two files."
	msg_join_saveFile_name="join of (${baseFileName}).pdf"
	msg_join_finish_title="Joined documents \"${baseFileName}\""
	msg_join_finish="Done."

	msg_add_openFile="Open document to add to \"${baseFileName}\""
	msg_add_saveFile_name="${baseFileName}_add.pdf"
	msg_add_finish_title="Added a document to \"${baseFileName}\""
	msg_add_finish="Done."

	msg_extract_inputPagesRange_title="Extract range"
	#msg_extract_inputPagesRange="Notes:\nThe keyword \"end\" may be used to reference the final page of a document instead of a page number.\nReference a single page by omitting the ending page number.\n\nPlease input pages range of \"${baseFileName}\" to extract:"
	msg_extract_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number. Reference a single page by omitting the ending page number. Please input pages range of \"${baseFileName}\" to extract:"
	msg_extract_saveFile_name="${baseFileName} (extracted pages).pdf"
	msg_extract_finish_title="Extracted pages from document \"${baseFileName}\""
	msg_extract_finish="Done."

	msg_extract_even_saveFile_name="${baseFileName} (even pages).pdf"
	msg_extract_even_finish_title="Extract all even pages from document \"${baseFileName}\""

	msg_extract_odd_saveFile_name="${baseFileName} (odd pages).pdf"
	msg_extract_odd_finish_title="Extract all odd pages from document \"${baseFileName}\""

	msg_burst_selectDir="Select destination directory"
	msg_burst_finish_title="Burst the document \"${baseFileName}\""
	msg_burst_finish="Done."

	msg_remove_inputPagesRange_title="Remove range"
	#msg_remove_inputPagesRange="Notes:\nThe keyword \"end\" may be used to reference the final page of a document instead of a page number.\nReference a single page by omitting the ending page number.\n\nPlease input pages range of \"${baseFileName}\" to remove:"
	msg_remove_inputPagesRange="Notes: The keyword \"end\" may be used to reference the final page of a document instead of a page number. Reference a single page by omitting the ending page number. Please input pages range of \"${baseFileName}\" to remove:"
	msg_remove_saveFile_name="${baseFileName} (removed pages).pdf"
	msg_remove_finish_title="Removing pages from document \"${baseFileName}\""
	msg_remove_finish="Done."

	msg_rotateLeft_saveFile_name="${baseFileName} (left rotated).pdf"
	msg_rotateLeft_finish_title="Left rotation of document \"${baseFileName}\""
	msg_rotateLeft_finish="Done."

	msg_rotateRight_saveFile_name="${baseFileName} (right rotated).pdf"
	msg_rotateRight_finish_title="Right rotation of document \"${baseFileName}\""
	msg_rotateRight_finish="Done."

	msg_rotateOverturn_saveFile_name="${baseFileName} (overturned).pdf"
	msg_rotateOverturn_finish_title="Overturn document \"${baseFileName}\""
	msg_rotateOverturn_finish="Done."

	msg_rotateOriginal_saveFile_name="${baseFileName} (restored).pdf"
	msg_rotateOriginal_finish_title="Restored original orientation of document \"${baseFileName}\""
	msg_rotateOriginal_finish="Done."

	msg_repair_saveFile_name="${baseFileName} (repaired).pdf"
	msg_repair_finish_title="Repair the document \"${baseFileName}\""
	msg_repair_finish="Done."

	msg_watermark_openFile_title="Open document for to watermark \"${baseFileName}\""
	msg_watermark_saveFile_name="${baseFileName} (watermarked).pdf"
	msg_watermark_finish_title="Watermark pages of document \"${baseFileName}\""
	msg_watermark_finish="Done."

	msg_stamp_openFile_title="Open document for to stamp \"${baseFileName}\""
	msg_stamp_saveFile_name="${baseFileName} (stamped).pdf"
	msg_stamp_finish_title="Stamp pages of document \"${baseFileName}\""
	msg_stamp_finish="Done."

	msg_lock_saveFile_name="${baseFileName} (locked).pdf"
	msg_lock_permissions_title="Select permissions"
	msg_lock_permissions_text="Select permissions for document \"${baseFileName}\""
	msg_lock_permissions_printing_top="Top Quality Printing"
	msg_lock_permissions_printing_degradedPrinting="Lower Quality Printing"
	msg_lock_permissions_printing_modifyContents="Modify"
	msg_lock_permissions_printing_CopyContents="Copy contents"
	msg_lock_permissions_printing_ModifyAnnotations="Modify annotations"
	msg_lock_insertPasswd_title="Insert password"
	#msg_lock_insertPassword_own="Master password is needed to set permissions.\n\nPlease define master password for \"${baseFileName}\":"
	msg_lock_insertPassword_own="Master password is needed to set permissions. Please define master password for \"${baseFileName}\":"
	#msg_lock_insertPassword_usr="Set user password if you want to allow only trusted people to read this file.\nThe master password and the user password must be different.\nIf you don't want this feature, leave text field empty.\n\nUser password of document \"${baseFileName}\":"
	msg_lock_insertPassword_usr="Set user password if you want to allow only trusted people to read this file. The master password and the user password must be different. If you don't want this feature, leave text field empty. User password of document \"${baseFileName}\":"
	msg_lock_finish_title="Lock the document \"${baseFileName}\""
	msg_lock_finish="Done."

	msg_unlock_insertPasswd_title="Insert password"
	msg_unlock_insertPassword_own="Please insert main password of \"${baseFileName}\":"
	msg_unlock_saveFile_name="${baseFileName} (unlocked).pdf"
	msg_unlock_finish_title="Unlock the document \"${baseFileName}\""
	msg_unlock_finish="Done."

	msg_attach_openFile_title="Open file for attach to \"${baseFileName}\""
	msg_attach_saveFile_name="${baseFileName} (with attachment).pdf"
	msg_attach_finish_title="Attach arbitrary file to document \"${baseFileName}\""
	msg_attach_finish="Done."

	msg_unattach_selectDir="Select extraction directory"
	msg_unattach_finish_title="Copy all attached files of document \"${baseFileName}\""
	msg_unattach_finish="Done."

	msg_uncompress_saveFile_name="${baseFileName} (uncompressed).pdf"
	msg_uncompress_finish_title="Uncompress the document \"${baseFileName}\""
	msg_uncompress_finish="Done."

	msg_compress_saveFile_name="${baseFileName} (compressed).pdf"
	msg_compress_finish_title="Compress the document \"${baseFileName}\""
	msg_compress_finish="Done."

	msg_info_title="Document information"
}

load_language_it () {
	msg_saveFile_title="Salva file ..."

	#msg_join_oneFileOnly="Non é possibile unire solo un file.\nPer favore, selezionane almeno due."
	msg_join_oneFileOnly="Non é possibile unire solo un file. Per favore, selezionane almeno due."
	msg_join_saveFile_name="unione di (${baseFileName}).pdf"
	msg_join_finish_title="Unione dei documenti \"${baseFileName}\""
	msg_join_finish="Finita."

	msg_add_openFile="Scegli il documento da aggiungere a \"${baseFileName}\""
	msg_add_saveFile_name="${baseFileName}_add.pdf"
	msg_add_finish_title="Aggiunta di un documento a \"${baseFileName}\""
	msg_add_finish="Conclusa."

	msg_extract_inputPagesRange_title="Range di estrazione"
	#msg_extract_inputPagesRange="Note:\nLa parola chiave \"end\" puó essere usata come riferimento alla pagina finale del documento al posto di un numero di pagina.\nÉ possibile riferirsi ad una singola pagina omettendo il numero di pagina finale.\n\nPer favore inserisci il range di pagine di \"${baseFileName}\" da estrarre:"
	msg_extract_inputPagesRange="Note: La parola chiave \"end\" puó essere usata come riferimento alla pagina finale del documento al posto di un numero di pagina. É possibile riferirsi ad una singola pagina omettendo il numero di pagina finale. Per favore inserisci il range di pagine di \"${baseFileName}\" da estrarre:"
	msg_extract_saveFile_name="${baseFileName} (pagine estratte).pdf"
	msg_extract_finish_title="Estrazione delle pagine dal documento \"${baseFileName}\""
	msg_extract_finish="Finita."

	msg_extract_even_saveFile_name="${baseFileName} (pagine pari).pdf"
	msg_extract_even_finish_title="Estrazione di tutte le pagine pari dal documento \"${baseFileName}\""

	msg_extract_odd_saveFile_name="${baseFileName} (pagine dispari).pdf"
	msg_extract_odd_finish_title="Estrazione di tutte le pagine dispari dal documento \"${baseFileName}\""

	msg_burst_selectDir="Seleziona la cartella di destinazione"
	msg_burst_finish_title="Divisione completa del documento \"${baseFileName}\""
	msg_burst_finish="Completata."

	msg_remove_inputPagesRange_title="Range di rimozione"
	#msg_remove_inputPagesRange="Note:\nLa parola chiave \"end\" puó essere usata come riferimento alla pagina finale del documento al posto di un numero di pagina.\nÉ possibile riferirsi ad una singola pagina omettendo il numero di pagina finale.\n\nPer favore inserisci il range di pagine di \"${baseFileName}\" da rimuovere:"
	msg_remove_inputPagesRange="Note: La parola chiave \"end\" puó essere usata come riferimento alla pagina finale del documento al posto di un numero di pagina. É possibile riferirsi ad una singola pagina omettendo il numero di pagina finale. Per favore inserisci il range di pagine di \"${baseFileName}\" da rimuovere:"
	msg_remove_saveFile_name="${baseFileName} (pagine rimosse).pdf"
	msg_remove_finish_title="Rimozione delle pagine dal documento \"${baseFileName}\""
	msg_remove_finish="Finita."

	msg_rotateLeft_saveFile_name="${baseFileName} (ruotato a sinistra).pdf"
	msg_rotateLeft_finish_title="Rotazione a sinistra del documento \"${baseFileName}\""
	msg_rotateLeft_finish="Eseguita."

	msg_rotateRight_saveFile_name="${baseFileName} (ruotato a destra).pdf"
	msg_rotateRight_finish_title="Rotazione a destra del documento \"${baseFileName}\""
	msg_rotateRight_finish="Eseguita."

	msg_rotateOverturn_saveFile_name="${baseFileName} (capovolto).pdf"
	msg_rotateOverturn_finish_title="Capovolgimento del documento \"${baseFileName}\""
	msg_rotateOverturn_finish="Concluso."

	msg_rotateOriginal_saveFile_name="${baseFileName} (ripristinato).pdf"
	msg_rotateOriginal_finish_title="Ripristino dell'orientazione originale del documento \"${baseFileName}\""
	msg_rotateOriginal_finish="Conclusa."

	msg_repair_saveFile_name="${baseFileName} (riparato).pdf"
	msg_repair_finish_title="Riparazione del documento \"${baseFileName}\""
	msg_repair_finish="Effettuata."

	msg_watermark_openFile_title="Scegli il documento da usare come filigrana per \"${baseFileName}\""
	msg_watermark_saveFile_name="${baseFileName} (con filigrana).pdf"
	msg_watermark_finish_title="Filigranatura delle pagine del documento \"${baseFileName}\""
	msg_watermark_finish="Completata."

	msg_stamp_openFile_title="Scegli il documento da usare come copertura di \"${baseFileName}\""
	msg_stamp_saveFile_name="${baseFileName} (coperto).pdf"
	msg_stamp_finish_title="Copertura delle pagine del documento \"${baseFileName}\""
	msg_stamp_finish="Finita."

	msg_lock_saveFile_name="${baseFileName} (protetto).pdf"
	msg_lock_permissions_title="Seleziona permessi"
	msg_lock_permissions_text="Seleziona permessi per il documento \"${baseFileName}\""
	msg_lock_permissions_printing_top="Stampa alla massima qualitá"
	msg_lock_permissions_printing_degradedPrinting="Stampa a bassa qualitá"
	msg_lock_permissions_printing_modifyContents="Modifica del contenuto"
	msg_lock_permissions_printing_CopyContents="Copia contenuto"
	msg_lock_permissions_printing_ModifyAnnotations="Modifica annotazioni"
	msg_lock_insertPasswd_title="Inserisci password"
	#msg_lock_insertPassword_own="La password principale é necessaria per impostare i permessi.\n\nPer favore inserisci la password principale di \"${baseFileName}\":"
	msg_lock_insertPassword_own="La password principale é necessaria per impostare i permessi. Per favore inserisci la password principale di \"${baseFileName}\":"
	#msg_lock_insertPassword_usr="La password utente è utile per consentire la lettura solo alle persone fidate.\nLa password principale e quella utente devono essere diverse.\nSe non vuoi usufruire di questa funzionalità lascia il seguente campo vuoto.\n\nPassword utente del documento \"${baseFileName}\":"
	msg_lock_insertPassword_usr="La password utente è utile per consentire la lettura solo alle persone fidate. La password principale e quella utente devono essere diverse. Se non vuoi usufruire di questa funzionalità lascia il seguente campo vuoto. Password utente del documento \"${baseFileName}\":"

	msg_lock_finish_title="Protezione del documento \"${baseFileName}\""
	msg_lock_finish="Eseguita."

	msg_unlock_insertPasswd_title="Inserisci password"
	msg_unlock_insertPassword_own="Per favore inserisci la passoerd principale di \"${baseFileName}\":"
	msg_unlock_saveFile_name="${baseFileName} (sprotetto).pdf"
	msg_unlock_finish_title="Sprotezione del documento \"${baseFileName}\""
	msg_unlock_finish="Eseguita."

	msg_attach_openFile_title="Scegli il file da allegare a \"${baseFileName}\""
	msg_attach_saveFile_name="${baseFileName} (con allegati).pdf"
	msg_attach_finish_title="Allegamento di un file al documento \"${baseFileName}\""
	msg_attach_finish="Concluso."

	msg_unattach_selectDir="Seleziona la cartella di estrazione"
	msg_unattach_finish_title="Copia di tutti i file allegati al documento \"${baseFileName}\""
	msg_unattach_finish="Conclusa."

	msg_uncompress_saveFile_name="${baseFileName} (scompattato).pdf"
	msg_uncompress_finish_title="Decompressione del documento \"${baseFileName}\""
	msg_uncompress_finish="Finita."

	msg_compress_saveFile_name="${baseFileName} (compressed).pdf"
	msg_compress_finish_title="Compressione del documento \"${baseFileName}\""
	msg_compress_finish="Finita."

	msg_info_title="Informazioni sul documento"
}

################################################

join () {
	if [ ${#} -lt 2 ]; then
		kdialog -sorry "${msg_join_oneFileOnly}"
		exit
	fi

	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon edit_add --getsavefilename "${workDir}/${msg_join_saveFile_name}" application/pdf`"
	pdftk "${@}" cat output "${outputFileName}" && \
	kdialog --title "${msg_join_finish_title}" --passivepopup "${msg_join_finish}" 5
}

add () {
	pdfToAdd="`kdialog --title "${msg_add_openFile}" --caption "${msg_add_openFile}" --icon editpaste --getopenfilename "." application/pdf`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editpaste --getsavefilename "${workDir}/${msg_add_saveFile_name}" application/pdf`"
	pdftk "${@}" "${pdfToAdd}" output "${outputFileName}" && \
	kdialog --title "${msg_add_finish_title}" --passivepopup "${msg_add_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

extract () {
	range=`kdialog --title "${msg_extract_inputPagesRange_title}" --caption "${msg_extract_inputPagesRange_title}" --icon editcopy --inputbox "${msg_extract_inputPagesRange}" "1-end"`
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_extract_saveFile_name}" application/pdf`"
	pdftk "${@}" cat ${range} output "${outputFileName}" && \
	kdialog --title "${msg_extract_finish_title}" --passivepopup "${msg_extract_finish}" 5
}

extract_even () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_extract_even_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endeven output "${outputFileName}" && \
	kdialog --title "${msg_extract_even_finish_title}" --passivepopup "${msg_extract_finish}" 5
}

extract_odd () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_extract_odd_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endodd output "${outputFileName}" && \
	kdialog --title "${msg_extract_odd_finish_title}" --passivepopup "${msg_extract_finish}" 5
}

burst () {
	burstDir="`kdialog --title "${msg_burst_selectDir}" --caption "${msg_burst_selectDir}" --icon editcopy --getexistingdirectory "."`"
	cd "${burstDir}" && \
	pdftk "${@}" burst output "${burstDir}/${baseFileName}_%04d.pdf" && \
	rm "${burstDir}/doc_data.txt" && \
	kdialog --title "${msg_burst_finish_title}" --passivepopup "${msg_burst_finish}" 5
}

remove () {
	range=`kdialog --title "${msg_remove_inputPagesRange_title}" --caption "${msg_remove_inputPagesRange_title}" --icon edit-delete-shred --inputbox "${msg_remove_inputPagesRange}" "2-end"`
	first=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/\(^[0-9][0-9]*\)-.*/\1/'`
	if [ "${first}" -gt 1 ]
		then range1="1-$(($first-1))"
	fi

	last=`echo "${range}" | sed 's/[[:blank:]]*//g' | sed 's/.*-\(.*$\)/\1/'`
	if [ ! "x${last}" = 'xend' ]
		then range2="$(($last+1))-end"
	fi

echo "remove from $first to $last"
echo "cat ($range1) ($range2)"
echo " uscita ${workDir}/${msg_remove_saveFile_name}"

	# if you want remove all pages
	if [ "x${range1}" = "x" ] && [ "x${range1}" = "x" ]
	    then exit
	fi

	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon edit-delete-shred --getsavefilename "${workDir}/${msg_remove_saveFile_name}" application/pdf`"
	pdftk "${@}" cat ${range1} ${range2} output "${outputFileName}" && \
	kdialog --title "${msg_remove_finish_title}" --passivepopup "${msg_remove_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

left () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_rotateLeft_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endL output "${outputFileName}" && \
	kdialog --title "${msg_rotateLeft_finish_title}" --passivepopup "${msg_rotateLeft_finish}" 5
}

right () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_rotateRight_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endR output "${outputFileName}" && \
	kdialog --title "${msg_rotateRight_finish_title}" --passivepopup "${msg_rotateRight_finish}" 5
}

overturn () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_rotateOverturn_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endD output "${outputFileName}" && \
	kdialog --title "${msg_rotateOverturn_finish_title}" --passivepopup "${msg_rotateOverturn_finish}" 5
}

restore () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon editcopy --getsavefilename "${workDir}/${msg_rotateOriginal_saveFile_name}" application/pdf`"
	pdftk "${@}" cat 1-endN output "${outputFileName}" && \
	kdialog --title "${msg_rotateOriginal_finish_title}" --passivepopup "${msg_rotateOriginal_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

repair () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon kpdf --getsavefilename "${workDir}/${msg_repair_saveFile_name}" application/pdf`"
	pdftk "${@}" output "${outputFileName}" && \
	kdialog --title "${msg_repair_finish_title}" --passivepopup "${msg_repair_finish}" 5
}

watermark () {
	background="`kdialog --title "${msg_watermark_openFile_title}" --caption "${msg_watermark_openFile_title}" --icon edit --getopenfilename "." application/pdf`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon edit --getsavefilename "${workDir}/${msg_watermark_saveFile_name}" application/pdf`"
	pdftk "${@}" background "${background}" output "${outputFileName}" && \
	kdialog --title "${msg_watermark_finish_title}" --passivepopup "${msg_watermark_finish}" 5
}

stamp () {
	stamp="`kdialog --title "${msg_stamp_openFile_title}" --caption "${msg_stamp_openFile_title}" --icon edit --getopenfilename "." application/pdf`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon edit --getsavefilename "${workDir}/${msg_stamp_saveFile_name}" application/pdf`"
	pdftk "${@}" stamp "${stamp}" output "${outputFileName}" && \
	kdialog --title "${msg_stamp_finish_title}" --passivepopup "${msg_stamp_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

lock () {
	own_passwd="`kdialog --title "${msg_lock_insertPasswd_title}" --caption "${msg_lock_insertPasswd_title}" --icon encrypted --password "${msg_lock_insertPassword_own}"`"
	usr_passwd="`kdialog --title "${msg_lock_insertPasswd_title}" --caption "${msg_lock_insertPasswd_title}" --icon encrypted --password "${msg_lock_insertPassword_usr}"`"
	permissions=`kdialog --title "${msg_lock_permissions_title}" --caption "${msg_lock_permissions_title}" --icon encrypted --checklist "${msg_lock_permissions_text}" Printing "${msg_lock_permissions_printing_top}" off DegradedPrinting "${msg_lock_permissions_printing_degradedPrinting}" off ModifyContents "${msg_lock_permissions_printing_modifyContents}" off CopyContents "${msg_lock_permissions_printing_CopyContents}" off ModifyAnnotations "${msg_lock_permissions_printing_ModifyAnnotations}" off --separate-output`
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon encrypted --getsavefilename "${workDir}/${msg_lock_saveFile_name}" application/pdf`"
	pdftk "${@}" output "${outputFileName}" allow ${permissions} owner_pw "${own_passwd}" user_pw "${usr_passwd}" && \
	kdialog --title "${msg_lock_finish_title}" --passivepopup "${msg_lock_finish}" 5
}

unlock () {
	passwd="`kdialog --title "${msg_unlock_insertPasswd_title}" --caption "${msg_unlock_insertPasswd_title}" --icon decrypted --password "${msg_unlock_insertPassword_own}"`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon decrypted --getsavefilename "${workDir}/${msg_unlock_saveFile_name}" application/pdf`"
	pdftk "${@}" input_pw "${passwd}" output "${outputFileName}" && \
	kdialog --title "${msg_unlock_finish_title}" --passivepopup "${msg_unlock_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

attach () {
	filesToAttach="`kdialog --title "${msg_attach_openFile_title}" --caption "${msg_attach_openFile_title}" --icon attach --getopenfilename "."`"
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon attach --getsavefilename "${workDir}/${msg_attach_saveFile_name}" application/pdf`"
	pdftk "${@}" attach_files "${filesToAttach}" output "${outputFileName}" && \
	kdialog --title "${msg_attach_finish_title}" --passivepopup "${msg_attach_finish}" 5
}

unattach () {
	outputDir="`kdialog --title "${msg_unattach_selectDir}" --caption "${msg_unattach_selectDir}" --icon attach --getexistingdirectory "${workDir}/"`"
	pdftk "${@}" unpack_files output "${outputDir}" && \
	kdialog --title "${msg_unattach_finish_title}" --passivepopup "${msg_unattach_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

uncompress () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon up --getsavefilename "${workDir}/${msg_uncompress_saveFile_name}" application/pdf`"
	pdftk "${@}" output "${outputFileName}" uncompress && \
	kdialog --title "${msg_uncompress_finish_title}" --passivepopup "${msg_uncompress_finish}" 5
}

compress () {
	outputFileName="`kdialog --title "${msg_saveFile_title}" --caption "${msg_saveFile_title}" --icon down --getsavefilename "${workDir}/${msg_compress_saveFile_name}" application/pdf`"
	pdftk "${@}" output "${outputFileName}" compress && \
	kdialog --title "${msg_compress_finish_title}" --passivepopup "${msg_compress_finish}" 5
}

#---------------------------------------------------------------------------------------------------------------------------------------------------

info () {
	msg="`pdftk "${@}" dump_data && echo ' '`"
	kdialog --title "${msg_info_title}" --msgbox "${msg}"
}

#### main

cd "${workDir}"
    "load_language_${lang}"
	"${action}" "${@}"
cd -
