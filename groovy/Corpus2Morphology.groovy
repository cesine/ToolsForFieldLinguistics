/*
 * Create a map of variables to send to the script
 */
def path = "/home/gina/Documents/workspacests/ToolsForFieldLinguistics/"
def language = "English"
def outdirectory = "gen"
Binding binding = new Binding()
binding.setVariable("path",path)
binding.setVariable("filename","../CorporaForFieldLinguistics/InuktitutRomanized/InukMagazine102-104rough-inuktitut.utf8.txt");
binding.setVariable("outdirectory",outdirectory)
binding.setVariable("language",language)
binding.setVariable("seeds","")
GroovyShell shell = new GroovyShell(binding);

/*
 * Can call the shell, use variables from the binding, and declare other variables
 */
//Object value = shell.evaluate("println 'Hello World!'; x = 123; return foo * 10");
//assert value.equals(new Integer(20));
//assert binding.getVariable("x").equals(new Integer(123));

//Call the Corpus2Wordlist script
def returnValue = shell.run(new File(path+"groovy/Corpus2Wordlist.groovy"), [])

//Call the Wordlist2SeedMorphList script
def seeds = shell.run(new File(path+"groovy/Wordlist2SeedMorphList.groovy"), [])
binding.setVariable("seeds",seeds)

shell = new GroovyShell(binding);
def precedencerelations = shell.run(new File(path+"groovy/SeedMorphList2PrecedenceRelations.groovy"), [])

binding.setVariable("precedencerelations",precedencerelations)
binding.setVariable("filename","${outdirectory}/${language}/Words-by_frequency.txt");
def densecorpus = shell.run(new File(path+"groovy/PrecedenceRelations2DenseCorpus.groovy"), [])

println densecorpus