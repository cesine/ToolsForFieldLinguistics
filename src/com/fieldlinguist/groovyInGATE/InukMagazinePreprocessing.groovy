//to change file encoding in vim :write ++enc=utf-8 russian.txt
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
                if(numberToStopTheLoopToShowOnlyPartOfIt >10){ break; }   //(to only run part of the loop)
            
                def words = line.split(" ")
                for (word in words){
                    out.print "<p>"+word+"</p>\n"
                    println "<p>"+word+"</p>\n"
                }
                
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

def  nunacomToUnicode(word){

return word.replaceAll('!','1').replaceAll('#','3').replaceAll('%','5').replaceAll('&','7').replaceAll("[(]",'9').replaceAll("[)]",'0').replaceAll('[*]','8').replaceAll('[/]','ᔭ').replaceAll('[?]','ᕙ').replaceAll('@','2').replaceAll('A','ᒍ').replaceAll('B','ᕼ').replaceAll('C','ᕋ').replaceAll('D','ᕈ').replaceAll('E','ᕆ').replaceAll('F','ᕕ').replaceAll('G','(').replaceAll('H',')').replaceAll('J','ᒧ').replaceAll('J','ᔪ').replaceAll('K','ᕗ').replaceAll('M','ᓚ').replaceAll('N','ᓇ').replaceAll('Q','ᒋ').replaceAll('S','ᐳ').replaceAll('W','ᐱ').replaceAll('X','ᐸ').replaceAll('Z','ᒐ').replaceAll('^','6').replaceAll('a','ᖑ').replaceAll('b','ᑕ').replaceAll('c','ᖃ').replaceAll('d','ᖁ').replaceAll('f','ᑯ').replaceAll('g','ᑐ').replaceAll('h','ᓱ').replaceAll('i','ᓂ').replaceAll('j','ᒧ').replaceAll('k','ᓄ').replaceAll('l','ᓗ').replaceAll('m','ᒪ').replaceAll('n','ᓴ').replaceAll('o','ᓕ').replaceAll('q','ᖏ').replaceAll('r','ᑭ').replaceAll('s','ᐅ').replaceAll('t','ᑎ').replaceAll('u','ᒥ').replaceAll('v','ᑲ').replaceAll('w','ᐃ').replaceAll('x','ᐊ').replaceAll('y','ᓯ').replaceAll('z','ᖓ').replaceAll('¡','!').replaceAll('â','ᑖ').replaceAll('Œ','ᒌ').replaceAll('μ','ᒫ').replaceAll('†','ᑏ').replaceAll('‰','‰').replaceAll('√','ᑳ').replaceAll('∫','ᑖ').replaceAll('∫','ᓂ').replaceAll('2','ᑉ').replaceAll('3','ᕐ').replaceAll('4','ᒃ').replaceAll('5','ᑦ').replaceAll('6','ᖅ').replaceAll('7','ᒻ').replaceAll('8','ᓐ').replaceAll('9','ᓪ')

}
