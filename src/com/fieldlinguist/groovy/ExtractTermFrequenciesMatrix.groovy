/*
This file is used to collect all word frequencies from a set of files.

*/


testSystemEncoding()
def frequencyMap = [:]
  
String corpora = "/Users/gina/Downloads/CorpusInuktitut/"
def dir = new File(corpora+'wordfrequencies/')
def title="InuktitutMagzine"
def outpath = corpora+"gen/"
def path = "${outpath}/${title}_word_frequencies_matrix_by_document.html"
OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(path),"UTF-8");

def numberToStopTheLoopToShowOnlyPartOfIt = 0
def fileVocabSize = "IM77\tIM79\tIM80\tIM81\tIM82\tIM83\tIM84\tIM85\tIM86\tIM87\tIM88\tIM89\tIM90\tIM91\tIM95\tIM96\tIM97\tIM98\tIM99\tIM100\tIM101\tIM102\tIM103\tIM104"
def fileWordCount = "IM77\tIM79\tIM80\tIM81\tIM82\tIM83\tIM84\tIM85\tIM86\tIM87\tIM88\tIM89\tIM90\tIM91\tIM95\tIM96\tIM97\tIM98\tIM99\tIM100\tIM101\tIM102\tIM103\tIM104"
Integer wordCountPerFile=0
def fileNumber = ""
try {
  files = dir.listFiles().grep(~/.*txt$/)
  
  println "The results will be created in this directory: ${title}"
  new File(outpath).mkdir()
       
  for(currentFile in files){
    println "======${currentFile}========"
    InputStreamReader sourcefile = new InputStreamReader(new FileInputStream(currentFile),"UTF-8");
    
    def individualfilename = currentFile.toString().split(/[\\\/]/)[-1]
    fileNumber = individualfilename.replace("Words_to_look_for_suffixes_file:_home_gina_Documents_workspacests_NonPublicCorpora_gen_InukMagzine_InukMagazine","IM").replace("_preprocessed_html.txt","")
    wordCountPerFile=0
		/*
     * Creates 1 file per file
     */
    try{
      numberToStopTheLoopToShowOnlyPartOfIt = 0                  //(to only run part of the Loop)
      while ( (line = sourcefile.readLine() ) != -1){
         
         numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)    
         //if(numberToStopTheLoopToShowOnlyPartOfIt >10 || line == null){ break; }    //(to only run part of the loop)

         if (line.length() > 1){
            def items = line.split("\t ")
            def word = items[1]
            def frequency = items[0]
						wordCountPerFile = wordCountPerFile + frequency.toInteger()
            /*
             *  If: the word isnt in the map, set its value to 1 because its the first occurrence
             *  Otherwise: increase its value because we just saw it again
             */
            if (null == frequencyMap[word]) {
                frequencyMap[word] = fileNumber+":::"+frequency
            } else {
                frequencyMap[word] = frequencyMap[word]+"\t"+fileNumber+":::"+frequency
            }
            //debugln "${word}  =>  ${frequencyMap[word]}"
          } 
       }//end loop for lines:
       println "==end of file ${numberToStopTheLoopToShowOnlyPartOfIt} Lines=="
       fileVocabSize = fileVocabSize.replace(fileNumber,numberToStopTheLoopToShowOnlyPartOfIt.toString())
			 fileWordCount = fileWordCount.replace(fileNumber,wordCountPerFile.toString())
    }catch(Exception ex) {
        println( "Successfully read ${numberToStopTheLoopToShowOnlyPartOfIt.toString()} lines, but there is a problem with line: "+ex.message)
        fileVocabSize = fileVocabSize.replace(fileNumber,numberToStopTheLoopToShowOnlyPartOfIt.toString())
    		fileWordCount = fileWordCount.replace(fileNumber,wordCountPerFile.toString())
		}
  }//end loop for files
}catch (Exception ex) {
    println("Problem with file: "+ex.message)
}
println "Finished processing files, here is the total vocab items per file\n"+fileVocabSize+"\n"
println "Finished processing files, here is the total word count per file\n"+fileWordCount+"\n"

out.append "\tVocabSize\t\t"+fileVocabSize+"\n"
out.append "\tWordCount\tTotal\t"+fileWordCount+"\n"

def count = 0;
def totalWords = frequencyMap.size()

try{
frequencyMap.entrySet().sort {
        /*
        This is a dense line which takes two entrys, compares their values to sort them by value.
        The meat of this operation is in the "sort" function which is implemented in the Map class...
        we dont need to know how it works, just copy paste the code...
        */
        anEntry,anotherEntry -> anotherEntry.key.reverse() <=> anEntry.key.reverse()
    }.each{
         sortedItem ->

           /*
             Here we do what we want with the sorted item, in this case, print it out to the file and to the console.
            */
            debugln "\n\n${sortedItem.key}  =>  ${sortedItem.value}"
            Integer totalFrequency = 0
            def frequencies = (sortedItem.value).split("\t")
            def newfrequencies = "IM77\tIM79\tIM80\tIM81\tIM82\tIM83\tIM84\tIM85\tIM86\tIM87\tIM88\tIM89\tIM90\tIM91\tIM95\tIM96\tIM97\tIM98\tIM99\tIM100\tIM101\tIM102\tIM103\tIM104"
            for (frequency in frequencies){
                def pieces = frequency.split(":::")
                def magazine = pieces[0]
                Integer value = pieces[1].toInteger()
                debugln frequency+" has the value " +value
                //Insert the count for that Issue of the magazine into the matrix
                newfrequencies=newfrequencies.replace(magazine,value.toString())
                
                totalFrequency = totalFrequency + value
            }
            Integer value = totalFrequency
                if( (value/totalWords)*1000 >10){
                    wordType ="FunctionalVery"
                }else if( (value/totalWords)*1000 >5){
                    wordType ="Functional"
                }else if( (value/totalWords)*1000 >3){
                    wordType ="FunctionalMaybe"
                }else if( (value/totalWords)*1000 >1){
                    wordType ="Frequent"
                }else {
                    wordType = "Content"
                }
            sortedItem.value = wordType+"\t"+totalFrequency+"\t"+newfrequencies.replaceAll(/IM1?[0-9][0-9]/,"0")
            count++
            out.append "${sortedItem.key}\t${sortedItem.value}\n"
                
  }



}catch (Exception ex) {
    println("Problem with a line in the frequency map: "+ex.message)
}
finally{
    out.flush()
    out.close()
}








/*
 Helper functions
*/

def debug(stringToPrint){
    //print stringToPrint
}
def debugln(stringToPrint){
    //println stringToPrint
}


def testSystemEncoding(){
    //System.setProperty("file.encoding", "UTF-8")
    println("The system encoding is : "+System.properties['file.encoding']+" (If it is not UTF-8, this script will not work as intended) ")
    println "This should look like Inuktitut: ᐊᑐᖃᑦᑕᖅᓯᒪᔭᖏᓐᓂᒃ ᐅᖃᐅᓯᖃᕐᓂᖅ"
   
}
