import java.util.HashMap

def defaultannots = docs[0].getAnnotations();
AnnotationSet words = docs[0].annotations.get('Token');

def out = new File("../gen/wordsbysuffix.txt")
out.delete()        
out = new File("../gen/wordsbysuffix.txt")

HashMap wordlist = [:].withDefault { k -> 0 }
def wordlistreversed = [:]
linecount=0
for(sentence in sentences){
   
    
    words.each{ key->
       
        if(key.getFeatures().get("string") ==~ /.+[a-z,A-Z].*/){
            def word =key.getFeatures().get("string").toLowerCase()
            
            if(word =~ /\d\d*/) {
                        println "This is a number, excluding it: $word"
            }else if (word.size() > 1) {
                        wordlist[word]++ 
            }
            linecount++
            assert (linecount < 5)//to avoid long run times while debugging
           
        }
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
                out.printf("%5d %s\n", [e.value, e.key.reverse()] )
            }



System.out.println("Sentences: "+sentences.size());