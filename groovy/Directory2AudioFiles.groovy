import groovy.util.AntBuilder;


	/*
	 * pass a directory or use the current directory
	 * source: http://tomionsoftware.blogspot.com/2006/08/groovy-get-all-xml-files-from.html
	 */
	//def folder = "gen/Yann_Martel_-_Life_of_Pi_(2001)"
	def folder = args?.size() ? args[0] : "."
	def bookname = folder.split(/[\\\/]/)[-1]
	println "reading files for $bookname from directory '$folder'"
	def basedir = new File(folder)
	
	// result files of the current run
	files = basedir.listFiles().grep(~/.*txt$/)
	def filenames =[]
	files.each(){ filenames.add(stripextention(it))}
	
	def instructions = "A new folder was created with your audio files inside.\n The application is currently using the Festival, Text to Speech System. \n Festival is an Open Source and Free voice system. \n As such it can be improved by anyone, even you!"
	new File("${folder}/README.txt").withWriter { out ->  out.print instructions }
	/*
	 * Loop through the filenames and create auido for each
	 */
	
	//for (currentFile in filenames) {
	//expecting filename in format: "${folder}/README"//
	def currentFile = filenames[0] //just do one file while in testing mode
	println "  processing $currentFile"
	/*
	 * Calling an external process to generate audio
	 * source: http://groovy.codehaus.org/Executing+External+Processes+From+Groovy
	 */
	def proc = [
		"text2wave",
		"${currentFile}.txt" ,
		"-o",
		"${currentFile}.wav"
	].execute()                 // Call *execute* on the string
	proc.waitFor()                               // Wait for the command to finish
	// Obtain status and output
	//println "return code: ${ proc.exitValue()}"
	//println "stderr: ${proc.err.text}"
	//println "stdout: ${proc.in.text}" // *out* from the external program is *in* for groovy
	
	
	proc = [
		"lame",
		"-V2" ,
		"${currentFile}.wav" ,
		"${currentFile}.mp3"
	].execute()                 // Call *execute* on the string
	proc.waitFor()                               // Wait for the command to finish
	// Obtain status and output
	//println "return code: ${ proc.exitValue()}"
	//println "stderr: ${proc.err.text}"
	//println "stdout: ${proc.in.text}" // *out* from the external program is *in* for groovy
	
	//} end loop for all files
	
	/*
	 * Zip the text and audio together
	 */
	def ant = new AntBuilder() 
	ant.zip(
			destfile: "gen/${bookname}.zip", 
			basedir: basedir
			//level: 9
			//excludes: "file3.dat"
			)
	
	/*
	 * Exit by printing instructions, generating the instructions in the README and the
	 * reading it to the user.
	 */
	println instructions
	currentFile = "${folder}/README"
	def procedure = [
		"text2wave",
		"${currentFile}.txt" ,
		"-o",
		"${currentFile}.wav"
	].execute()                 // Call *execute* on the string
	procedure.waitFor()                               // Wait for the command to finish
	procedure = [
		"lame",
		"-V2" ,
		"${currentFile}.wav" ,
		"${currentFile}.mp3"
	].execute()                 // Call *execute* on the string
	procedure.waitFor()                               // Wait for the command to finish
	procedure = [
		"mpg123",
		"${folder}/README.mp3"
	].execute()                 // Call *execute* on the string
	procedure.waitFor()
	
	/*
	 * End script
	 */


/*
 * Begin Function definitions
 */

def stripextention(n){
	
	/* TODO
	 * figure out why replace all cant be called on some arguments (namely the arguments generated in  basedir.listFiles() above)
	 * currently: forced conversion to a string so that replace all wouldnt give errors
	 * 		No signature of method: java.io.File.replaceAll() is applicable for argument types: (java.lang.String, java.lang.String)
	 * 
	 */
	
	String m = n;
	return m.replaceAll(/\.(txt|pdf|wav)/,'')
}