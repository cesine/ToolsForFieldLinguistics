
/*
Step 2: prepare your map to hold the word:frequency pairs
ex: the:388  Means that the word "the" appears 388 times in the document
*/

def frequencyMap = [:]

def word = "Hi"
//make the word lowercase, this is optional it depends on what your goal is.
//word = word.toLowerCase()

    /*
     *  If: the word isnt in the map, set its value to 1 because its the first occurrence
     *  Otherwise: increase its value because we just saw it again
     */
    if (null == frequencyMap[word]) {
                frequencyMap[word] = 1
    } else {
                frequencyMap[word]++
    }
    
/*
Test it, 
   assert that the value of the word is 1, 
   increase the value, 
   then assert that the value is 2
*/
assert (frequencyMap[word] == 1)
frequencyMap[word]++
assert frequencyMap[word] == 2

/*
For curiosity, 
    take a look at what the map looks like
    add another word
    take a look again
*/
print "This is what a 'map' looks like"+ frequencyMap

word = "not"
//word = word.toLowerCase()
    if (null == frequencyMap[word]) {
                frequencyMap[word] = 1
    } else {
                frequencyMap[word]++
    }
assert frequencyMap[word] == 1
print "\nThis is what the map looks like with two words:"+frequencyMap




