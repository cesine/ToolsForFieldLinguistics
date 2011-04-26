/*TODO: generate meta information about the subtitles such as author, publisher and title. could use the
			web to get the information by taking a snippet of text and googling for it.
*/
try {
	String NonPublicCorpora = "/Users/gina/Documents/workspacests/NonPublicCorpora/"
	/*
	 * get all files in directory containing substring, 
	 * for each file, extract the dialogs
	 * 
	 */	
	def subtitlesDir = new File(NonPublicCorpora+'subtitles/')
	files = subtitlesDir.listFiles().grep(~/.*Megamind.*srt$/)
	def title="Megamind_Movie"
	for(currentFile in files){	
		sourcefile = new FileReader(currentFile)
	
		/*Fetch the last element of a list
			Given the list [Red, Green, Blue], access the last element ('Blue')
			result = list[-1]
			*/
		def subtitlesfilename = currentFile.toString().split(/[\\\/]/)[-1]
		def albumfolder=title
		def outpath = "gen/${albumfolder}"
		new File(outpath).mkdir()
		println "The subtitles results will be created in this directory: ${albumfolder}"
		/*
		 * Creates 1 file of dialogs per episode
		 */
		def out = new FileWriter("${outpath}/${subtitlesfilename}_Dialogs.txt")
		try{
			try{
				sourcefile.eachLine{
					if (it =~ /^\d\d*$/){
						//println "This is the subtitle number: $it"
						out.print "\n"
						out.print it.trim()
					}
					if (it =~ /[A-Za-z]/){
						//it = checksubripmistakes(it)
						out.print "\t"
						out.print it.trim()
					}else{
						//println "This should be numbers: $it"
					}
				}
			}finally{
				out.close()
			}
		}catch(e) { }		
	}//end loop for files
}catch (Exception ex) {
	System.err.println(ex.message)
}
/*
 * Below are helping functions
 */


/*
 * Checking for systematic mistakes made when the subtitles are from SubRip, an OCR subtitler which recognizes images and turns
 * them into text. Due to Subtitle font being in Arial, SubRip often mixes up 
 * 		l and I and 
 * 		ligatures (Sh ->Dh) 
 * 
 * Below are a list of rules to correct the mistakes.
 * 
 * Ideally this process should be done by a combination of:
 * 		possible clusters in the Language, (implemented statistics rather than linguistic knowledge)
 * 		checking edit distance (phonemic, orthographic and keyboard proximity)
 *  	and probably word frequencies outside the subtitles to fix the mistakes the rules create
 *   		(often in proper names) Example: "Abu Dhabi" is correct, but the rule creates "Abu Shabi"
 * 
 * Correcting the hypercorrection:
 * 		Running a word count in this set of subtitles vs a word count in a document might identify words which are wrong due to SubRib
 * 		But it also might misidentify words which are simply popular in this movie. 
 * 
 */
def checksubripmistakes(line){
	sylableNucleus='aeiouy'
	sylableCoda='pbmftdnszckgh'
	sonorant='mnlrsh'
	sylableOnset=sylableCoda
	wordBoundary='^$<>.-,!? '
	
	//wellformedEnglishWord=wordBoundary+sylableOnset?+sonorant?+sylableNucleus+sonorant?+sylableCoda?+wordBoundary
	correctedLine=line
	
	
	//checking for l instead of I
	if (correctedLine =~ /([ >])l([ 'nstrwpkjhgfdzxvbm])/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/([ >])l([ 'nstrwpkjhgfdzxvbm])/,'$1I$2')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	if (correctedLine =~ /^l([ 'nstrwpkjhgfdzxvbm])/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/^l([ 'nstrwpkjhgfdzxvbm])/,'I$1')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	
	
	
	//checking for I instead of l
	if (correctedLine =~ /I([Iaeiouywj])/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/I([Iaeiouy])/,'l$1')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	if (correctedLine =~ /([a-z])I/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/([a-z])I/,'$1l')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	
	//checking for . instead of ,
	if (correctedLine =~ /\.(  *[a-z])/){
		//println "This contains a potential punctuation mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/\.(  *[a-z])/,',$1')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	
	
	//checking for D instead of S
	if (correctedLine =~ /D([TCSPKJGFHDZXVBMnstpkjgfhdzxvbmy])/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/D([TCSPKJGFHDZXVBMnstpkjgfhdzxvbmy])/,'S$1')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	//checking for Damantha
	if (correctedLine =~ /Damantha/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/Damantha/,'Samantha')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	//checking for DAMANTHA
	if (correctedLine =~ /DAMANTHA/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/DAMANTHA/,'SAMANTHA')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	/*checking for RODE that should be ROSE, in sex and the city
	if (correctedLine =~ /RODE/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/RODE/,'ROSE')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	*/
	
	
	
	/*
	 * Begin checking for hypercorrections (corrections which shouldn't have been made)
	 */
	
	
	
	//checking for Abu Shabi
	if (correctedLine =~ /Abu Shabi/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/Abu Shabi/,'Abu Dhabi')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	if (correctedLine =~ /Dorry/){
		//println "This contains a potential spelling mistake. \t $correctedLine"
		correctedLine=correctedLine.replaceAll(/Dorry/,'Sorry')
		//println "\tThis is the corrected line: \t $correctedLine"
	}
	
	
	return correctedLine
}