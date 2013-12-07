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


//set up the hash which will contain precedence rules and counts with default of 0
def precedencerelations = [:].withDefault { k -> 0 }

def initials = seeds[0]
def medials = seeds[1]
def finals = seeds[2]

/*
 * Initials are 
 *  1: word initial
 *  2: precede medials
 *  3: precede finals (design choice)
 */
for (initial in initials){
	//add it as an initial, say it proceeds the medials
	precedencerelations["@ > ${initial}"]++
	for (med in medials){
		//say that that initial proceeds all medials
		precedencerelations["${initial} > ${med}"]++
	}
//	design choice 
//	for (fin in finals){
//		//say that that initial proceeds all finals
//		precedencerelations["${initial} > ${fin}"]++
//	}
}
/*
 * Medials are
 *  1: before finals
 */
for (med in medials){
	for (fin in finals){
		//say that that medials proceeds all finals
		precedencerelations["${med} > ${fin}"]++
	}
	//don't claim that medials can end a word.
	//precedencerelations["${med} > @"]++
}
/*
 * Finals are 
 * 1: at the end of the word
 */
for (fin in finals){
	precedencerelations["${fin} > @"]++
}

return precedencerelations