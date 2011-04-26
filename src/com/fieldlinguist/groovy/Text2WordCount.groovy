import groovy.swing.SwingBuilder
import java.awt.FlowLayout as FL
import javax.swing.BoxLayout as BXL

/*File access from http://pleac.sourceforge.net/pleac_groovy/fileaccess.html

// test values (change for your os and directories)
inputPath='Pleac/src/pleac7.groovy'; outPath='Pleac/temp/junk.txt'

// For input Java uses InputStreams (for byte-oriented processing) or Readers
// (for character-oriented processing). These can throw FileNotFoundException.
// There are also other stream variants: buffered, data, filters, objects, ...
inputFile = new File(inputPath)
inputStream = new FileInputStream(inputFile)
reader = new FileReader(inputFile)
inputChannel = inputStream.channel

*/

//
try {
	textspath=opentextsource(args)
	sourcefile = new FileReader(textspath)

	/*
	 * Print the lines which contain the word, breaking on the word chapter
	 *
	 * /using withWriter() always closes the File, whatever is thrown inside
		//closure...
		try{
		  new File('TestFile3.txt').withWriter(){ w->
	 */
	/*Fetch the last element of a list
		Given the list [Red, Green, Blue], access the last element ('Blue')
		groovy
		list = ['Red', 'Green', 'Blue']
		result = list[-1]
		
		so in line below, it splits the texts path based on either windows \ or linux / slashes,
		and takes the last element to be the filename of the texts
		TODO: generate meta information abou the texts such as author, publisher and title. could use the
		web to get the information by taking a snippet of text and googling for it.
		*/
	textspath=textspath.replaceAll(/Dialogs\.txt$/,'')
	def textsfilename = textspath.split(/[\\\/]/)[-1]
	def albumfolder=textsfilename.replaceAll(/\.txt$/,'')
		
	def outpath = "gen/${albumfolder}"
	new File(outpath).mkdir()
	println "The texts results will be created in this directory: ${albumfolder}"
	
	
	def wordlist = [:].withDefault { k -> 0 }
	def wordlistreversed = [:]
	linecount=0
	try{
		try{
			sourcefile.eachLine{
				it=it.trim()
				//get rid of html markup
				it=it.replaceAll(/<\/?[^>]>/,'')
				//remove apostrophe's to turn don't into dont, as one word
				it=it.replaceAll(/\'/,'')
				it=it.toLowerCase()

				//split line into words
				words = it.split(/\W+/) 
				//println "Words:\t $words"
				
				words.each { 
					if(it =~ /\d\d*/) {
						//println "This is a number, excluding it: $it"
					}else if (it.size() > 1) {
						wordlist[it]++ 
					}
				}
				//println "Wordlist:\t $wordlist \n\n"
	
				linecount++
				//assert (linecount < 5)
			}
			
			def wordlistout = new FileWriter("${outpath}/Words-by_frequency.txt")
			def longwordsout =new FileWriter("${outpath}/Long_Words-by_frequency.txt")
			def suffixesout = new FileWriter("${outpath}/Words-by_suffixes.txt")
			
			// output map in a descending numeric sort of its values
			wordlist.entrySet().sort { a,b -> b.value <=> a.value }.each{ e ->
				wordlistout.printf("%5d %s\n", [e.value, e.key] )
				if(e.key =~/.*[aeiouy].*[aeiouy][^aeiouy]+[aeiouy].*[aeiouy].*[aiouy]/){
					longwordsout.printf("%5d %s\n", [e.value, e.key] )
				}
			}
			
			/*
			 * make a new map with the words backwards
			 * sort them by alphabetical order (essentailly allowing a sort by suffix)
			 * print them out (reversing each so that it is spelled normally) with their word counts
			 * 
			 * Result:
			 		8 crazy
				    1 sexy
				    9 guy
				    4 buy
				    9 pretty
				    1 amnesty
				    1 nasty
				    1 forty
				    2 liberty
				    2 party
				    1 certainty
				    1 twenty
			 */
			wordlist.each{e ->
				wordlistreversed[e.key.reverse()]= e.value
			}
			wordlistreversed.entrySet().sort { a,b -> b.key <=> a.key }.each{ e ->
				suffixesout.printf("%5d %s\n", [e.value, e.key.reverse()] )
			}
			//println "The words backwards: $wordlistreversed"
			
		}finally{
			sourcefile.close()
			wordlistout.close()
			longwordsout.close()
			suffixesout.close()
		}
	}catch(e) { }
	
	
	
}catch (Exception ex) {
	System.err.println(ex.message)
}

//return outpath

def opentextsource(args){
	/*TODO get better logic to get filename from user
	prompt = '\n> '
	print 'Enter filename:' + prompt
	new BufferedReader(new InputStreamReader(System.in)).eachLine{ line ->
		
		println "Read: $line" // normal output to System.out
	}
		/*
		 * end logic to get filename from user
		 */
	
	/*
	 * pass a directory or use the current directory
	 * source: http://tomionsoftware.blogspot.com/2006/08/groovy-get-all-xml-files-from.html
	 */
	//def folder = "gen/Yann_Martel_-_Life_of_Pi_(2001)"
	if (args?.size()){
		sourcefile = args[0]
		println "There were arguments, using $sourcefile"
		return sourcefile
	}else{
		println "There were no arguments using hard coded."
		def s = new SwingBuilder()
		s.setVariable('myDialog-properties',[:]) //-- 1 --//
		def vars = s.variables //-- 2 --//
		def dial = s.dialog(title:'Dialog 1',id:'myDialog',modal:true) { //-- 3 --//
			panel() {
				boxLayout(axis:BXL.Y_AXIS)
				panel(alignmentX:0f) {
					flowLayout(alignment:FL.LEFT)
					label('File path')
					textField(id:'name',columns:10) //-- 4 --//
				}
				panel(alignmentX:0f) {
					flowLayout(alignment:FL.LEFT)
					button('OK',preferredSize:[80,24],
						   actionPerformed:{
							   vars.dialogResult = 'OK' //-- 5 --//
							   dispose()
					})
					button('Cancel',preferredSize:[80,24],
						   actionPerformed:{
							   vars.dialogResult = 'cancel'
							   dispose()
					})
				}
			}
		}
		dial.pack()
		dial.show()
		
		//println 'and the result is: ' + vars.dialogResult
		println 'the file entered is: ' + vars.name.text
		if ("OK".equals(vars.dialogResult) ){
			return vars.name.text
		}else{
			return 'gen/Sex.and.The.City.2.2010.READNFO.DVDRip.XviD-DUBBY/Dialogs.txt'
		}
	}
		return 'error'
	
}