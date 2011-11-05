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
  def albumfolder=title
  def outpath = NonPublicCorpora+"gen/${albumfolder}"
  println "The results will be created in this directory: ${albumfolder}"
  new File(outpath).mkdir()

  
  for(currentFile in files){
    sourcefile = new FileReader(currentFile)
    def individualfilename = currentFile.toString().split(/[\\\/]/)[-1]
    /*
     * Creates 1 file of dialogs per episode
     */
    def out = new FileWriter("${outpath}/${individualfilename.replaceAll('.txt','')}_preprocessed.html")
    try{
      try{
      
          out.print "<html>\n"
          def numberToStopTheLoopToShowOnlyPartOfIt = 0                  //(to only run part of the Loop)
            for (line in sourcefile){
                numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)    
                if(numberToStopTheLoopToShowOnlyPartOfIt >1000){ break; }   //(to only run part of the loop)
            
                println "This is a line: $line"
                def tag = ""
                def languageCount = 0
                if ( line =~ /[wxy]\d/ ){
                    tag = tag+"inuktitut"
                    languageCount++
                }
                if ( line.toLowerCase().contains("ful") || line.toLowerCase().contains("the") || line.toLowerCase().contains(" or ")){
                    tag = tag+"english"
                    languageCount++
                }
                if ( line.toLowerCase().contains("ux") || line.toLowerCase().contains("Ž") || line.toLowerCase().contains(" ˆ ") || line.toLowerCase().contains(" en ") || line.toLowerCase().contains(" le ") || line.toLowerCase().contains(" de ") ){
                    tag = tag+"francais"
                    languageCount++
                }
                if (line.toLowerCase().contains("qq") || line.toLowerCase().contains("tt") || line.toLowerCase().contains("jj") || line.toLowerCase().contains("ii") || line.toLowerCase().contains("unga") || line =~ /[jkmtv]u[qt] / ){
                    tag = tag+"inuktitutRomanized"
                    languageCount++
                }
                if ("" == tag){
                    tag = "unknown"
                }
                tag = tag + languageCount
                out.print "<p><${tag}>"+line.trim()+"</${tag}></p>\n"
            }
      }finally{
        
        out.print "</html>\n"
        out.close()
      }
    }catch(e) { }
    
    }//end loop for files
}catch (Exception ex) {
  System.err.println(ex.message)
}


