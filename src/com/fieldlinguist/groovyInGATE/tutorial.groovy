import java.util.HashMap

/*
Step 1: get the Tokens Annotation Set from Gate
*/
def defaultannots = docs[0].getAnnotations()
AnnotationSet words = docs[0].annotations.get('Token')

/*
Assert that the words set has more than 0 elements (basically to make sure that the import worked)
*/
assert(words.size()>0)

/*
Print the size of the word set, just for fun to see how many words we have to work with...
*/
print (words.size())


/*
Step 2: prepare your map to hold the word:frequency pairs
ex: the:388  Means that the word "the" appears 388 times in the document
*/

def frequencyMap = [:]

def numberToStopTheLoopToShowOnlyPartOfIt = 0
/*
Loop through the words
*/
for(wordObject in words){
    numberToStopTheLoopToShowOnlyPartOfIt ++
    if(numberToStopTheLoopToShowOnlyPartOfIt >5){ break; }
    
    //The words come out as objects from gate(with a lot of values...)
    print "\n"+wordObject
    word = wordObject.getFeatures().get("string")
    //make the word lowercase, this is optional it depends on what your goal is.
    word = word.toLowerCase()

    /*
     *  If: the word isnt in the map, set its value to 1 because its the first occurrence
     *  Otherwise: increase its value because we just saw it again
     */
    if (null == frequencyMap[word]) {
                frequencyMap[word] = 1
    } else {
                frequencyMap[word]++
    }
    
}//end for loop to go through all the words

print "This is what the frequency map looks like\n"+ frequencyMap


