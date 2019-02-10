mport java.util.HashMap

/*
Step 1: get the Tokens annotation set from Gate
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
for 10 minutes every time we run it (depending on the size of the document). 
*/
def frequencyMap = [:]
def numberToStopTheLoopToShowOnlyPartOfIt = 0                  //(to only run part of the loop)
/*
Step 3
Loop through the words, adding it to the frequency map
*/
for(wordObject in words){
    numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)
    if(numberToStopTheLoopToShowOnlyPartOfIt >125){ break; }   //(to only run part of the loop)
    
    //we just want the string of the word
    word = wordObject.getFeatures().get("string")
    //make the word lowercase, this is optional, it depends on what your goal is.
    word = word.toLowerCase()
    
    /*
    Step 4
    Get rid of non-words, only use words that have an lowercase or uppercase letter in the middle 
    For more info: Google: regular expressions groovy
    ( Could do anything that is only letters: [a-z,A-Z]* but this is a bad assumption for IPA or romanized arabic chat, or passamaquoddy where numbers are used to represent sounds
    */
    if (word ==~ /.*[a-zA-Z].*/){
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

/*
Step 5 
Print out the list by frequency (could use this to look for function vs content words)
*/
def outpath = ""  //change this to any path you want
new File(outpath).mkdir()

def frequencyOrderFileOut = new FileWriter("${outpath}Words_function_vs_content.txt")

// output map in a descending numeric sort of its values
print "\nThis is what the frequency map looks like when its sorted by value and printed using our own formating.\n"
frequencyMap.entrySet().sort { 
        /*
        This is a dense line which takes two entrys, compares their values to sort them by value. 
        The meat of this operation is in the "sort" function which is implemented in the Map class...
        we dont need to know how it works, just copy paste the code...
        */
        anEntry,anotherEntry -> anotherEntry.value <=> anEntry.value 
    }.each{
         sortedItem ->
             /*
             Here we do what we want with the sorted item, in this case, print it out to the file and to the console.
             */
            frequencyOrderFileOut.append "${sortedItem.value}\t ${sortedItem.key}\n"
            print "${sortedItem.value}\t ${sortedItem.key}\n"
}

/*
Always remember to flush the pipes when your done :)
*/
frequencyOrderFileOut.flush()
frequencyOrderFileOut.close()


/*
Step 5b:
If you flip all teh words around sort them, then flip them back you can get a list of words ordered by 
"Rhyming order" which means you can write new rap lyrics, 
or you can find words with similar endings to control for coda type in phonology,
or you can find suffixes because 4-6 words in a row will have have the same 3 letters at the end..
*/
def rhymingOrderFileOut = new FileWriter("${outpath}Words_to_look_for_suffixes.txt")



print "\nNow lets look for some suffixes....\n\n"
def backwardsWordsMap = [:]

frequencyMap.each{entry ->
    //reverse the word and save it into the new map for backwards words, keeping its old value
    backwardsWordsMap[entry.key.reverse()]= entry.value
}
/*
sort through the map of backwards words
*/
print "\nThis is what the frequency map looks like when its sorted alphabetically but from the back of the word and printed using our own formating.\n"

backwardsWordsMap.entrySet().sort { 
        //this time, take two entries, and just compare their key (ie, the words aphabetically)
        a,b ->  a.key <=> b.key 
    }.each{ 
        sortedItem ->
            rhymingOrderFileOut.append "${sortedItem.value}\t ${sortedItem.key.reverse()}\n"
            print "${sortedItem.value}\t ${sortedItem.key.reverse()}\n" 

}
rhymingOrderFileOut.flush()
rhymingOrderFileOut.close()




