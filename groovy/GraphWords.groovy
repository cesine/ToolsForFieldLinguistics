
import java.util.regex.Pattern

def defaultannots = docs[0].getAnnotations();
AnnotationSet sentences = docs[0].annotations.get('Sentence');
def wordmap = []
def out = new File("/home/gina/Documents/outputGraph.html")
out.delete()        
out = new File("/home/gina/Documents/outputGraph.html")
for(sentence in sentences){
    out.append("var g = new Graph();\n")

    AnnotationSet contentWords =  docs[0].annotations.get("ContentWord", sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset() );
    //contentWord.addAll(  docs[0].annotations.get("CollectionNounCluster", sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset() ) )
    def contentWordList = []

    
    contentWords.each{ key->
       
        if(key.getFeatures().get("string") ==~ /.+[a-z,A-Z].*/){
            contentWordList.add(key.getFeatures().get("string").toLowerCase() ) 
        }
    }
    def contentWordListCopy = contentWordList
    contentWordList.each{ key ->
        //out.append "${key}"
        for(i in contentWordList){ 
            //out.append "\t${i}"
            wordmap.add("g.addEdge(${key},${i});\n")
            out.append ("g.addEdge(${key},${i});\n")
        }
    }
}
System.out.println("Sentences: "+sentences.size());