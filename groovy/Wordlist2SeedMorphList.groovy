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

def initials = []
def medials = []
def finals = []
//Inuktitut seeds:
if (language =="InuktitutRomanized"){
	initials = ["isuma", "kati", "tusaa", "mali", "malik", "tiki", "tikit", "nuna"]
	medials = ["sima", "laur", "lauq", "nngit", "vallia"]
	finals = ["juq", "tugut", "mik"]
}
else{
	initials = ["re", "de", "un"]
	medials = ["en","ness"]
	finals = ["ed", "ly", "s"]
}

def seeds = [initials,medials,finals]
return seeds