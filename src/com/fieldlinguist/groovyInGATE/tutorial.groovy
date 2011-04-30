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
print "This is how many words we have "+ (words.size())


/*
Step 2: prepare your map to hold the word:frequency pairs
ex: the:388  Means that the word "the" appears 388 times in the document


While we are debugging, lets only loop through part of the words! Otherwise we might have to wait
for 10 minutes every time we run it. 
*/
def frequencyMap = [:]
def numberToStopTheLoopToShowOnlyPartOfIt = 0                 //(to only run part of the loop)
/*
Loop through the words
*/
for(wordObject in words){
    numberToStopTheLoopToShowOnlyPartOfIt ++                 //(to only run part of the loop)
    if(numberToStopTheLoopToShowOnlyPartOfIt >15){ break; }   //(to only run part of the loop)
    
    //we just want the string of the word
    word = wordObject.getFeatures().get("string")
    //make the word lowercase, this is optional it depends on what your goal is.
    word = word.toLowerCase()
    
    /*
    get rid of non-words, only use words that have an lowercase or uppercase letter in the middle 
    For more info: Google: regular expressions groovy
    ( Could do anything that is only letters: [a-z,A-Z]* but this is a bad assumption for IPA or romanized arabic chat, or passamaquoddy where numbers are used to represent sounds
    */
    if (word ==~ /.+[a-z,A-Z].*/){
        //its okay, so process it
        
        /*
         *  If: the word isnt in the map, set its value to 1 because its the first occurrence
         *  Otherwise: increase its value because we just saw it again
         */
        if (null == frequencyMap[word]) {
                frequencyMap[word] = 1
        } else {
                frequencyMap[word]++
        }
    }else{
        //good to print out to make sure your regular expression is discarding the right junk
        print "\nDiscarding this as junk: "+word
    }

}//end for loop to go through all the words

print "\n\nAll Done. \n This is what the frequency map looks like\n"+ frequencyMap


