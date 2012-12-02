import java.util.HashMap

//System.setProperty("file.encoding", "UTF-8");
println("The system encoding is : "+System.properties['file.encoding']+" (If it is not UTF-8, this script will not work as intended) ");
println "This should look like Inuktitut: ᐊᑐᖃᑦᑕᖅᓯᒪᔭᖏᓐᓂᒃ ᐅᖃᐅᓯᖃᕐᓂᖅ"
for (doc in docs){
/*
Step 1: get the Tokens annotation set from Gate
*/
def defaultannots = doc.getAnnotations()
AnnotationSet words = doc.annotations.get('Token')
def documentTitle = doc.getSourceUrl().toString().replaceAll("[./ ]","_")
print documentTitle + "will be used in the output file names so that you know where the data came from"
/*
Assert that the words set has more than 0 elements (basically to make sure that the import worked)
*/
//assert(words.size()>0)
def totalWords=words.size()

/*s
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
    //if(numberToStopTheLoopToShowOnlyPartOfIt >10){ break; }   //(to only run part of the loop)
    
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
    if (word ==~ /.*[ᐁ-ᙶa-zA-Z].*/){
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
        print " Discarding this as junk: "+word
    }

}//end for loop to go through all the words

//print "\n\nAll Done. \n This is what the frequency map looks like\n"+ frequencyMap

/*
Step 5
Print out the list by frequency (could use this to look for function vs content words)
*/


/*
Mac or Linux: /Users/username/Documents/ToolsForFieldLinguistics/src/com/fieldlinguist/
Windows: C:/blah/blah/ToolsForFieldLinguistics/src/com/fieldlinguist/
*/
def outpath = "/home/gina/Documents/workspacests/ToolsForFieldLinguistics/src/com/fieldlinguist/"  //change this to the path of your repository
new File(outpath).mkdir()

def frequencyOrderFileOut = new FileWriter("${outpath}outputtxt/Words_function_vs_content_${documentTitle}.txt")
def frequencyOrderVisualizeOut = new FileWriter("${outpath}javascript/bargraph/Words_function_vs_content_${documentTitle}.html")
//frequencyOrderVisualizeOut.append "<!DOCTYPE html> <html> <head> <meta http-equiv=\"content-type\" content=\"text/html;charset=UTF-8\" /> <title>Function Words to content words in Blogworkorange</title> <link href=\"basic.css\" type=\"text/css\" rel=\"stylesheet\" /> <script type=\"text/javascript\" src=\"enhance.js\"></script> <script type=\"text/javascript\"> // Run capabilities test    \n        enhance({ \n            loadScripts: [ \n                {src: 'excanvas.js', iecondition: 'all'}, \n                '../jquery/jquery.min.js', \n                'visualize.jQuery.js', \n                'example_wordCount.js' \n            ], \n            loadStyles: [ \n                'visualize.css', \n                'visualize-dark.css' \n            ]     \n        });     </script> </head> <body> <table >"
//frequencyOrderVisualizeOut.append "\n <caption>Functional vs Content words: Blogworkorange</caption> <thead> <tr> <td></td> <th scope=\"col\">count</th> </tr> </thead> <tbody>"
frequencyOrderVisualizeOut.append "<!DOCTYPE html>\n\n<html lang=\"en\">\n<head>\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n  <title>Word Frequencies in ${documentTitle}</title>\n  <!--[if lt IE 9]><script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/excanvas.js\"></script><![endif]-->\n  \n  <link rel=\"stylesheet\" type=\"text/css\" href=\"../jqplot/src/jquery.jqplot.css\" />\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"examples/examples.css\" />\n  \n  <!-- BEGIN: load jquery -->\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/jquery-1.5.1.min.js\"></script>\n  <!-- END: load jquery -->\n  \n  <!-- BEGIN: load jqplot -->\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/jquery.jqplot.js\"></script>\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/plugins/jqplot.enhancedLegendRenderer.js\"></script>\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/plugins/jqplot.pieRenderer.js\"></script>\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/plugins/jqplot.barRenderer.js\"></script>\n  <script language=\"javascript\" type=\"text/javascript\" src=\"../jqplot/src/plugins/jqplot.categoryAxisRenderer.js\"></script>\n  <!-- END: load jqplot -->\n\n<style type=\"text/css\">\n    div.plot {\n        margin-bottom: 70px;\n    }\n/*    div.jqplot-table-legend-swatch {\n    width: 0px;\n    height: 0px;\n    border-width: 3px 4px;\n    }\n    td.jqplot-table-legend > div {\n        padding: 1px;\n        border: 1px solid #dedede;\n    }*/\n    \n    pre {\n        background: #D8F4DC;\n        border: 1px solid rgb(200, 200, 200);\n        padding-top: 1em;\n        padding-left: 3em;\n        padding-bottom: 1em;\n        margin-top: 1em;\n        margin-bottom: 3em;\n        \n    }\n    \n    p {\n        margin: 2em 0;\n    }\n    \n    #chart2 .jqplot-table-legend {\n/*        margin-left: 10px;*/\n    }\n</style>\n\n<script id=\"example_1\" type=\"text/javascript\">\$(document).ready(function(){\n\n   s1 = ["

def functionContentWordHighlighter = new FileWriter( "${outpath}japegrammars/Words_function_vs_content_${documentTitle}.jape")
functionContentWordHighlighter.append "Phase:   TagContentAndFuntionalWords\nInput: Token\nOptions: control = appelt\n\n\n"


// output map in a descending numeric sort of its values
//print "\nThis is what the frequency map looks like when its sorted by value and printed using our own formating.\n"
def count = 0;
def maxY=0;
def maxX=0;
def wordType ="Functional"
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
            if(count ==0){ 
                //the max Y axis is the most frequent word, ie the first word
                maxY=sortedItem.value
            }
            frequencyOrderFileOut.append "${sortedItem.value}\t ${sortedItem.key}\n"
            //frequencyOrderVisualizeOut.append "\n<tr> <th scope=\"row\">${sortedItem.key}</th> <td>${sortedItem.value}</td> </tr>"
            frequencyOrderVisualizeOut.append "${sortedItem.value}, "
            if( (sortedItem.value/totalWords)*1000 >10){
                wordType ="FunctionalVery"
            }else if( (sortedItem.value/totalWords)*1000 >5){
                wordType ="Functional"
            }else if( (sortedItem.value/totalWords)*1000 >3){
                wordType ="FunctionalMaybe"
            }else if( (sortedItem.value/totalWords)*1000 >1){
                wordType ="Frequent"
            }else {
                wordType = "Content"
            }
            functionContentWordHighlighter.append "Rule: aa${count}\n(\n {Token.string == \"${sortedItem.key}\"}\n )\n:section -->\n  :section.${wordType} = {kind = \"${wordType}\", documentCount=\"${sortedItem.value}\" string=:section.Token.string}\n\n"
            count++

            //print "${sortedItem.value}\t ${sortedItem.key}\n"+sortedItem.value/totalWords*100
            
  }
//the x axis is as long as the number of words in the vocabulary
maxX=count
/*
Always remember to flush the pipes when your done :)
*/
frequencyOrderFileOut.flush()
frequencyOrderFileOut.close()


//frequencyOrderVisualizeOut.append "\n</tbody> </table> </body> </html>"
frequencyOrderVisualizeOut.append "];\n\n   plot1 = \$.jqplot('chart1',[s1],{\n       stackSeries: true,\n        seriesDefaults: {\n            fill: true,\n            showMarker: false\n        },\n       legend:{\n           renderer: \$.jqplot.EnhancedLegendRenderer,\n           show:true,\n           labels:['Count', 'Rain', 'Frost', 'Sleet', 'Hail', 'Snow'],\n           rendererOptions:{\n               numberColumns:3\n           }\n              },\n            axes: {\n                   xaxis:{min:1, max:${maxX}},\n                   yaxis:{min:0, max:${maxY}}\n                }\n   });\n});\n</script>\n  \n<script id=\"example_2\" type=\"text/javascript\">\$(document).ready(function(){\n    plot2 = \$.jqplot('chart2',[s1],{\n        stackSeries: true,\n        seriesDefaults: {\n            renderer: \$.jqplot.BarRenderer\n        },\n        legend:{\n            renderer: \$.jqplot.EnhancedLegendRenderer,\n            show:true,\n            showLabels: true,\n            labels:['Count', 'Rain', 'Frost', 'Sleet', 'Hail', 'Snow'],\n            rendererOptions:{\n                numberColumns:1,\n                seriesToggle: 900,\n                disableIEFading: false\n            },\n            placement:'outside',\n            shrinkGrid: true\n        },\n        axes: {\n            xaxis:{renderer: \$.jqplot.CategoryAxisRenderer},\n            yaxis:{min:0, max:${maxY}\n        }\n    });\n});\n</script>\n  \n<script id=\"example_3\" type=\"text/javascript\">\$(document).ready(function(){\n   plot3 = \$.jqplot('chart3',[s1],{\n       stackSeries: true,\n        seriesDefaults: {\n            fill: false,\n            showMarker: false\n        },\n       legend:{\n           renderer: \$.jqplot.EnhancedLegendRenderer,\n           show:true,\n           showSwatches: false,\n           labels:['Count', 'Rain', 'Frost', 'Sleet', 'Hail', 'Snow'],\n           rendererOptions:{\n               numberRows:1\n           },\n           placement:'outside',\n           location:'s',\n           marginTop: '30px'\n              },\n            axes: {\n                   xaxis:{min:1, max:${maxX}},\n                   yaxis:{min:0, max:${maxY}}\n                }\n   });\n});\n</script>\n  \n<script id=\"example_4\" type=\"text/javascript\">\$(document).ready(function(){\n    plot4 = \$.jqplot('chart4', [[['A',25],['B',14],['C',7],['D', 13],['E', 11],['F',35]]], {\n      seriesDefaults:{\n          renderer:\$.jqplot.PieRenderer\n      },\n      legend:{\n          show:true, \n          rendererOptions:{\n              numberColumns:2\n          }\n      }      \n    });\n   \n });\n</script>\n\n<script type=\"text/javascript\">\n    \$(document).ready(function(){\n        \n        \$('#code_1').html(\$('#example_1').html());\n        \$('#code_2').html(\$('#example_2').html());\n        \$('#code_3').html(\$('#example_3').html());\n        \$('#code_4').html(\$('#example_4').html());\n        \$(document).unload(function() {\$('*').unbind(); });\n\n    });\n</script> \n  </head>\n  <body>\n\n<div id=\"chart1\" class=\"plot\" style=\"width:800px;height:300px;\"></div>\n\n    \n<!--<div id=\"chart2\" class=\"plot\" style=\"width:800px;height:300px;\"></div>\n\n\n<div id=\"chart3\" class=\"plot\" style=\"width:800px;height:300px;\"></div>\n\n<div id=\"chart4\" class=\"plot\" style=\"width:500px;height:300px;\"></div>\n-->\n    \n  </body>\n</html>\n"
frequencyOrderVisualizeOut.flush()
frequencyOrderVisualizeOut.close()

functionContentWordHighlighter.flush()
functionContentWordHighlighter.close()
/*
Step 5b:
If you flip all teh words around sort them, then flip them back you can get a list of words ordered by
"Rhyming order" which means you can write new rap lyrics,
or you can find words with similar endings to control for coda type in phonology,
or you can find suffixes because 4-6 words in a row will have have the same 3 letters at the end..
*/
print "\nNow lets look for some suffixes....\n\n"
def rhymingOrderFileOut = new FileWriter("${outpath}outputtxt/Words_to_look_for_suffixes_${documentTitle}.txt")
def backwardsWordsMap = [:]

frequencyMap.each{entry ->
    //reverse the word and save it into the new map for backwards words, keeping its old value
    backwardsWordsMap[entry.key.reverse()]= entry.value
}
/*
sort through the map of backwards words
*/
print "\nThis is what the frequency map looks like when its sorted alphabetically, but from the back of the word and printed using our own formating.\n"

backwardsWordsMap.entrySet().sort {
        //this time, take two entries, and just compare their key (ie, the words aphabetically)
        a,b ->  a.key <=> b.key
    }.each{
        sortedItem ->
            /*
            Here we do what we want with the sorted item,
            In this case we print it out, but we are sure to reverse it when we print so that it comes out human-readable (instead of backwards)
            */
            rhymingOrderFileOut.append "${sortedItem.value}\t ${sortedItem.key.reverse()}\n"
            //print "${sortedItem.value}\t ${sortedItem.key.reverse()}\n"

}
rhymingOrderFileOut.flush()
rhymingOrderFileOut.close()

print totalWords
}