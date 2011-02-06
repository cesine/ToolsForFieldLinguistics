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
	bookpath=opentextsource()
	sourcefile = new FileReader(bookpath)

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
		
		so in line below, it splits the book path based on either windows \ or linux / slashes, 
		and takes the last element to be the filename of the book
		TODO: generate meta information abou the book such as author, publisher and title. could use the
		web to get the information by taking a snippet of text and googling for it. 
		*/
	def bookfilename = bookpath.split(/[\\\/]/)[-1]
	def albumfolder=bookfilename.replaceAll(/\.txt$/,'')
		
	def outpath = "gen/${albumfolder}"
	new File(outpath).mkdir()
	println "The book will be created in this directory: ${albumfolder}"
	
	def out = new FileWriter("${outpath}/00preface.txt")
	try{
		try{
			sourcefile.eachLine{
				if (it =~ /Chapter/){
					println "Found a break point: ${it}"
					def filename= it.trim().replaceAll(/ /,'_')+".txt"
					println "Do you want to create a file ${filename}"
					
					out.close()
					out = new FileWriter("${outpath}/${filename}")
				}
				out.println it
			}
		}finally{
			out.close()
		}
	}catch(e) { }
	
	
}catch (Exception ex) {
    System.err.println(ex.message)
}

return outpath

def opentextsource(){
	/*TODO get better logic to get filename from user
	prompt = '\n> '
	print 'Enter filename:' + prompt
	new BufferedReader(new InputStreamReader(System.in)).eachLine{ line ->
		
		println "Read: $line" // normal output to System.out
	}
		/*
		 * end logic to get filename from user
		 */
		
		return '/home/gina/books/Yann_Martel_-_Life_of_Pi_(2001).txt'
	
}
