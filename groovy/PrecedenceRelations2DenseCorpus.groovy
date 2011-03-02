import java.util.regex.Pattern
import java.util.regex.Matcher

def morphologicalTemplate = precedenceRelations2morphologyTemplate(precedencerelations)
def longWordRegEx = morphologicalTemplate2regEx(morphologicalTemplate)
def densecorpus = regEx2denseCorpus(longWordRegEx)

return densecorpus

/*
 * 
 * Begin Functions: 
 * 
 * 
 */



/*
 * take any regular expression, find words matching that regular expression and split it up into morpheme boundaries using the (.*)(.*) parenthesis of the regex
 */
def  regEx2denseCorpus(longWordRegEx){
	def maxPositions= longWordRegEx.count("(")
	def components = []
	for (int i = 0; i<maxPositions; i++){
		components[i]="t"+i
	}
	println components
	println maxPositions
	println longWordRegEx
	
	def wordlist = new HashSet()
	def a="(kati|nuna).*(mik|tanga)"
	
	try {
		
		sourcefile = new FileReader(path+filename)
		sourcefile.eachLine{
			it=it.trim()
			it=it.toLowerCase()
			
			//split line into words
			words = it.split(/\W+/)
			//println "Words:\t $words"
			words.each {
				/*
				 * If the word matches, wrap each section of the word in +initial+ +medial+ +final+ etc
				 */
				if(it =~ /$longWordRegEx/) {
					println "processing: " +it
					//http://stackoverflow.com/questions/292097/groovy-grep-a-word
					String resultString = ""
					Pattern regex = Pattern.compile(longWordRegEx);
					Matcher regexMatcher = regex.matcher(it);
					try{
						regexMatcher.find()
						resultString=resultString+ " +"+regexMatcher.group(1)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(2)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(3)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(4)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(5)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(6)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(7)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(8)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(9)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(10)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(11)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(12)+"+ "
						resultString=resultString+ " +"+regexMatcher.group(13)+"+ "
					}catch(e){
						//if the template is smaller than 13 error silently..
					}
					println resultString
					
					wordlist.add(resultString)
				}
			}
		}
	
	}catch (Exception ex) {
		System.err.println(ex.message)
	}
	
	return wordlist
}

def precedenceRelations2morphologyTemplate(precedencerelations){
	List relations = new ArrayList(precedencerelations.keySet());
	println "number of relations left to process = ${relations.size}"
	def relationsToRemove = []
	def morphtemplate =[]
	
	//priming condition
	def position =0
	morphtemplate[position]= ["@"]
	
	//Recursive while loop, exit condition is to remove relations until all are processed
	while(relations.size > 0){
		position++
		//Go through relations, this time looking for relations which start with that initial, put the morphemes which follow them into a new Set (used set to only keep unique elements
		morphtemplate[position] = new HashSet()
		for (relation in relations){
			//for all the morph in k-1 position
			for (morph in morphtemplate[position-1]){
				if (relation =~ /^$morph >/){
					morphtemplate[position].add( relation.toString().replace("${morph} > ","") )
					//println "working on relation: ${relation}"
					relationsToRemove.add(relation)
				}
			}
		}
		relationsToRemove.each{
			relations.remove(it)
		}
		relationsToRemove =[]
		println "number of relations left to process = ${relations.size}"
	}
	
	return morphtemplate
}


/*
 * A function which takes an array of arrays (morphemes in positions in a template)
 * and returns a finitestatemachine(a regex) which can be used to find larger words which match the template.
 *
 *
 * [	0		1		2		3		4 ]
 * 		@		isuma	laur	tugut	@
 * 				kati	lauq	mik	
 * 				mali	sima	juq
 * 				...		...		...
 *
 */
def morphologicalTemplate2regEx(morphologicalTemplate){
	def finitestatemachine = "(.*)"
	for(position in morphologicalTemplate){
		finitestatemachine=finitestatemachine+"("
		for(morph in position){
			finitestatemachine=finitestatemachine+morph+"|"
		}
		finitestatemachine=finitestatemachine+")(.*)"
	}
	finitestatemachine=finitestatemachine.replaceAll(/\|\)/,")")
	finitestatemachine=finitestatemachine.replaceAll(/\(@\)\(\.\*\)/,"")
	
	return finitestatemachine
}
