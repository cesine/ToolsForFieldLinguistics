def defaultannots = docs[0].getAnnotations();
AnnotationSet sentences = docs[0].annotations.get('Sentence');
def wordmap = []
def out = new File("gen/outGraph.js")
out.delete()        
out = new File("gen/outputGraph.js")
out.append ("""
var redraw, g, renderer;

/* only do all this when document has finished loading (needed for RaphaelJS) */
window.onload = function() {
    
    var width = \$(document).width() - 20;
    var height = \$(document).height() - 60;
    
    g = new Graph();
""")

for(sentence in sentences){
    //out.append("\ng = new Graph();\n")

    AnnotationSet contentWords =  docs[0].annotations.get("ContentWord", sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset() );
    //contentWord.addAll(  docs[0].annotations.get("CollectionNounCluster", sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset() ) )
    def contentWordList = []

    
    contentWords.each{ key->
       
        if(key.getFeatures().get("string") ==~ /.+[a-z,A-Z].*/){
            def word =key.getFeatures().get("string").toLowerCase()
            contentWordList.add(word ) 
            out.append("\n\tg.addNode(\"${word}\");")
        }
    }
    def contentWordListCopy = contentWordList
    contentWordList.each{ key ->
        //out.append "${key}"
        for(i in contentWordList){ 
            //out.append "\t${i}"
            wordmap.add("\n\tg.addEdge(\"${key}\",\"${i}\");")
            out.append ("\n\tg.addEdge(\"${key}\",\"${i}\");")
        }
    }
}
out.append("""

    /* layout the graph using the Spring layout implementation */
    var layouter = new Graph.Layout.Spring(g);
    
    /* draw the graph using the RaphaelJS draw implementation */
    renderer = new Graph.Renderer.Raphael('canvas', g, width, height);
    
    redraw = function() {
        layouter.layout();
        renderer.draw();
    };
    hide = function(id) {
        g.nodes[id].hide();
    };
    show = function(id) {
        g.nodes[id].show();
    };
    //    console.log(g.nodes["kiwi"]);
};""")
System.out.println("Sentences: "+sentences.size());
