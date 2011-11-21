import java.util.HashMap

/*
Step 1: Open Inuktitute Roots from a file */
def corporaDir = "/Users/hisakonog/Documents/iLanguage/CorporaForFieldLinguistics/InuktitutRomanized/"
def currentFile = corporaDir+"roots.txt"
InputStreamReader sourcefile = new InputStreamReader(new FileInputStream(currentFile),"UTF-8");
    

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
for(line in sourcefile){
    numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)
    //if(numberToStopTheLoopToShowOnlyPartOfIt > 10){ break; }   //(to only run part of the loop)
    
    //println line 
   
    
    word = line.toLowerCase()
    
    /*
    Step 4
    Get rid of non-words, only use words that have an lowercase or uppercase letter in the middle
    For more info: Google: regular expressions groovy
    ( Could do anything that is only letters: [a-z,A-Z]* but this is a bad assumption for IPA or romanized arabic chat, or passamaquoddy where numbers are used to represent sounds
    */
    if ( (word ==~ /.*[a-zA-Z].*/) && (word.length() > 2) && !(word.contains("&")) ){
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
        println "Discarding this as junk: :"+word+":"
    }

}//end for loop to go through all the words

//println "\n\nAll Done. \n This is what the frequency map looks like\n"+ frequencyMap

/*
Step 5
Print out the jape rules for each root 
*/


/*
Mac or Linux: /Users/username/Documents/ToolsForFieldLinguistics/src/com/fieldlinguist/
Windows: C:/blah/blah/ToolsForFieldLinguistics/src/com/fieldlinguist/
*/
def outpath = "/Users/hisakonog/Documents/iLanguage/ToolsForFieldLinguistics/src/com/fieldlinguist/"  //change this to the path of your repository
new File(outpath).mkdir()

def rootHighlighter = new FileWriter( "${outpath}japegrammars/Inuktitut_Roots_Generated.jape")
rootHighlighter.append '''
/*
 * This jape grammar tags words in color code to see words with common roots
 It ignores any word containing & (the lateral fricative) which we dont see in the romanized inuktitut from inuk magazine anyway. 
 TODO try to find what this sound corresponds to in InukMagazine romanized and dont ignore these roots, instead, change the & into its equivalent.
 
 
 Discarding this as junk: ::
Discarding this as junk: :ai:
Discarding this as junk: :aa:
Discarding this as junk: :aar&uq:
Discarding this as junk: :ai:
Discarding this as junk: :aik&iq:
Discarding this as junk: :ak&a:
Discarding this as junk: :ak&u:
Discarding this as junk: :ak&unaaq:
Discarding this as junk: :apak&iq:
Discarding this as junk: :ii:
Discarding this as junk: :ik&i:
Discarding this as junk: :ik&irvik:
Discarding this as junk: :ikak&ak:
Discarding this as junk: :ir&irpak:
Discarding this as junk: :ir&u:
Discarding this as junk: :is&uaq:
Discarding this as junk: :is&uuraq:
Discarding this as junk: :ju:
Discarding this as junk: :kak&u:
Discarding this as junk: :kalaa&&it:
Discarding this as junk: :kallupi&&uk:
Discarding this as junk: :kangiq&iniq:
Discarding this as junk: :kangir&uk:
Discarding this as junk: :kik&u:
Discarding this as junk: :mak&ak:
Discarding this as junk: :mik&i:
Discarding this as junk: :mik&iaq:
Discarding this as junk: :minaumik&iq:
Discarding this as junk: :nir&ingu:
Discarding this as junk: :pi:
Discarding this as junk: :qak&i:
Discarding this as junk: :qak&uttuq:
Discarding this as junk: :qar&u:
Discarding this as junk: :qat&apak:
Discarding this as junk: :qimir&uk:
Discarding this as junk: :su:
Discarding this as junk: :tur&uaq:
Discarding this as junk: :tur&uk:
Discarding this as junk: :ui:
Discarding this as junk: :ua:
 
 */
Phase:   TagRoots
Input: Token
Options: control = appelt
'''

def count = 0 
def wordType ="LexicographyKnown"
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
             Here we do what we want with the sorted item, in this case, print it out to the file as a jape rule.
             */
           
            rootHighlighter.append '''
            Rule: aa'''+count+'''a
            (
             {Token.string ==~ \"'''+sortedItem.key+'''.*\"}
              )
              :section -->
                :section.'''+wordType+''' = {kind = \"'''+wordType+'''\",  string=:section.Token.string}
                
            Rule: aa'''+count+'''b
            (
             {Token.string ==~ \"'''+sortedItem.key+'''.*\"}
              )
              :section -->
                :section.'''+sortedItem.key+''' = {kind = \"Root\",  string=:section.Token.string}
                
                '''
            count = count+1

  }

/*
Always remember to flush the pipes when your done :)
*/
rootHighlighter.flush()
rootHighlighter.close()

println frequencyMap.size()