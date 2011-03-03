/*
 * The script expects to be called from another script with a binding passed to it
 * 
 * For example:
 * 
		def path = "/home/gina/Documents/workspacests/ToolsForFieldLinguistics/"
		Binding binding = new Binding()
		binding.setVariable("path",path)
		binding.setVariable("filename","../CorporaForFieldLinguistics/InuktitutRomanized/InukMagazine102-104rough-inuktitut.utf8.txt");
		binding.setVariable("outdirectory","gen")
		binding.setVariable("language","InuktitutRomanized")
		binding.setVariable("seeds","")
		GroovyShell shell = new GroovyShell(binding);
		
		def returnValue = shell.run(new File(path+"groovy/Corpus2Wordlist.groovy"), [])

 */


try {
	sourcefile = new FileReader(path+filename)
	def outpath = "${path}${outdirectory}/${language}/"
	//println outpath
	new File(outpath).mkdir()
	def wordlistout = new FileWriter("${outpath}Words-by_frequency.txt")
	def longwordsout =new FileWriter("${outpath}Long_Words-by_frequency.txt")
	def suffixesout = new FileWriter("${outpath}Words-by_suffixes.txt")
	
	
	def wordlist = [:].withDefault { k -> 0 }
	def wordlistreversed = [:]
	linecount=0
	try{
		try{
			sourcefile.eachLine{
				it=it.trim()
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
			
			// output map in a descending numeric sort of its values
			wordlist.entrySet().sort { a,b -> b.value <=> a.value }.each{ e ->
				//println e.value+","+e.key
				wordlistout.printf("%5d %s\n", [e.value, e.key] )
				if(e.key =~/.*[aeiouy].*[aeiouy].*[aeiouy].*[aeiouy].*[aeiouy][^aeiouy]+[aeiouy].*[aeiouy].*[aiouy]/){
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
				suffixesout.printf("%5d %30s\n", [e.value, e.key.reverse()] )
			}
			//println "The words backwards: $wordlistreversed"
			
		}finally{
			sourcefile.close()
			wordlistout.close()
			longwordsout.close()
			suffixesout.close()
		}
	}catch(e) { 
		System.err.println(e.message)
	}
	
	
}catch (Exception ex) {
	System.err.println(ex.message)
}

return "filelocation"

