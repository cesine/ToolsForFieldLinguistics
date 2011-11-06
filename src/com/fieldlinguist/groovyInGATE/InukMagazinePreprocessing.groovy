//to change file encoding in vim :write ++enc=utf-8 
import java.util.HashMap

/*
Step 1: open the text files
*/
try {
  String NonPublicCorpora = "/Users/gina/Documents/workspacests/NonPublicCorpora/"
  def inukMagazinesDir = new File(NonPublicCorpora+'magazines/InukMagazine/')
  println inukMagazinesDir
  
  files = inukMagazinesDir.listFiles().grep(~/.*txt$/)
  println files
 
  def title="InukMagzine"
  def outpath = NonPublicCorpora+"gen/${title}"
  println "The results will be created in this directory: ${title}"
  new File(outpath).mkdir()

  
  for(currentFile in files){
    println "======${currentFile}========"
    InputStreamReader sourcefile = new InputStreamReader(new FileInputStream(currentFile),"UTF-8");
    
    def individualfilename = currentFile.toString().split(/[\\\/]/)[-1]
    /*
     * Creates 1 file per file
     */
    def path = "${outpath}/${individualfilename.replaceAll('.txt','')}_preprocessed.txt"
    OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(path),"UTF-8");
    try{
        out.append "<html>\n"
        def numberToStopTheLoopToShowOnlyPartOfIt = 0                  //(to only run part of the Loop)
        while (true){
            line = sourcefile.readLine()
            numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)    
            if(numberToStopTheLoopToShowOnlyPartOfIt >40 || line == null){ break; }    //(to only run part of the loop)
                
            if (line.length() > 1){
              out.append "<p>"
              def words = line.split(" ")
              for (word in words){
                print word+" "
                if( (word =~ /[a-zA-Z]\d/) || (word =~ /[a-z][A-Z]/) ){
                   try {
                     word = nunacomToUnicode(word)
                     print " : "+ word+" " 
                   }catch(Exception ex) {
                        println( "\n\nProblem with word: "+ex.message)
                   }
                 }
                 out.append word+ " "
              }
              out.append "</p>\n"
              println ""
            } 
        }//end loop for lines:
        println "==end of file=="
    }catch(Exception ex) {
        println( "Problem with line: "+ex.message)
    }finally{
        out.append "</html>\n"
        out.flush()
        out.close()
    }
  }//end loop for files
}catch (Exception ex) {
  println("Problem with file: "+ex.message)
}

def  nunacomToUnicode(word){

    return word.replaceAll('!','1').replaceAll('#','3').replaceAll('%','5').replaceAll('&','7').replaceAll("[(]",'9').replaceAll("[)]",'0').replaceAll('[*]','8').replaceAll('[/]','?').replaceAll('[?]','?').replaceAll('@','2').replaceAll('A','?').replaceAll('B','?').replaceAll('C','?').replaceAll('D','?').replaceAll('E','?').replaceAll('F','?').replaceAll('G','(').replaceAll('H',')').replaceAll('J','?').replaceAll('J','?').replaceAll('K','?').replaceAll('M','?').replaceAll('N','?').replaceAll('Q','?').replaceAll('S','?').replaceAll('W','?').replaceAll('X','?').replaceAll('Z','?').replaceAll('^','6').replaceAll('a','?').replaceAll('b','?').replaceAll('c','?').replaceAll('d','?').replaceAll('f','?').replaceAll('g','?').replaceAll('h','?').replaceAll('i','?').replaceAll('j','?').replaceAll('k','?').replaceAll('l','?').replaceAll('m','?').replaceAll('n','?').replaceAll('o','?').replaceAll('q','?').replaceAll('r','?').replaceAll('s','?').replaceAll('t','?').replaceAll('u','?')//.replaceAll('v','?').replaceAll('w','?').replaceAll('x','?').replaceAll('y','?').replaceAll('z','?').replaceAll('Á','!').replaceAll('‰','?').replaceAll('Î','?').replaceAll('?','?').replaceAll(' ','?').replaceAll('ä','ä').replaceAll('Ã','?').replaceAll('º','?').replaceAll('º','?').replaceAll('2','?').replaceAll('3','?').replaceAll('4','?').replaceAll('5','?').replaceAll('6','?').replaceAll('7','?').replaceAll('8','?').replaceAll('9','?')

}