//to change file encoding in vim :write ++enc=utf-8 
import java.util.HashMap

//System.setProperty("file.encoding", "UTF-8");

/*
Step 1: open the text files
*/
try {
  String NonPublicCorpora = "/Users/gina/Documents/workspacests/NonPublicCorpora/"
  def inukMagazinesDir = new File(NonPublicCorpora+'magazines/InukMagazine/')
  files = inukMagazinesDir.listFiles().grep(~/.*txt$/)
  
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
            if(numberToStopTheLoopToShowOnlyPartOfIt >20 || line == null){ break; }    //(to only run part of the loop)
                
            if (line.length() > 1){
              println line
              out.append "<p>"
              def words = line.split(" ")
              for (word in words){
                if( !(word =~ /\d\d/) && ( (word =~ /[^ \d]\d/) || (word =~ /[^ ABCDEFGHIJKLMNOPQRSTUVWXYZ][A-Z]/) || (word =~ /xb/) || (word =~ /\d[a-zA-Z][a-zA-Z]/) ) ){
                   try {
                     word = nunacomToUnicode(word)
                     //print " : "+ word+" " 
                   }catch(Exception ex) {
                        println( "\n\nProblem with word: "+ex.message)
                   }
                 }
                 if(word ==~ /^[ᖕᑉᕐᒃᑦᖅᒻᓐᓪᔾ].*/){
                     print "_"+word
                     out.append "_"+word
                 }else{
                     print " "+word
                     out.append " "+word
                 }
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
    
    //println(System.properties['file.encoding']);
    //println "ᓕᖏᖑᒪᕿᓕᐃᕿᑭᓂᓕᓴᓄᑲᖁ"
    //System.out.println nunacomToUnicode("weciwmoe4")
        //.replaceAll('^','6')
    word = word.replaceAll('‰','ᕇ').replaceAll('[/]','ᔭ').replaceAll('[?]','ᕙ').replaceAll('A','ᒍ').replaceAll('C','ᕋ').replaceAll('D','ᕈ').replaceAll('E','ᕆ').replaceAll('F','ᕕ').replaceAll('j','ᒧ').replaceAll('I','ᖤ').replaceAll('J','ᔪ').replaceAll('K','ᕗ').replaceAll('L','ᖢ').replaceAll('M','ᓚ').replaceAll('N','ᓇ').replaceAll('O','ᖠ').replaceAll('P','ᖦ').replaceAll('Q','ᒋ').replaceAll('R','ᖖ').replaceAll('S','ᐳ').replaceAll('T','ᙱ').replaceAll('U','ᙵ').replaceAll('V','?').replaceAll('W','ᐱ').replaceAll('X','ᐸ').replaceAll('Y','ᙳ').replaceAll('Z','ᒐ').replaceAll('a','ᖑ').replaceAll('b','ᑕ').replaceAll('c','ᖃ').replaceAll('d','ᖁ').replaceAll('e','ᕿ').replaceAll('f','ᑯ').replaceAll('g','ᑐ').replaceAll('h','ᓱ').replaceAll('i','ᓂ').replaceAll('j','ᒧ').replaceAll('k','ᓄ').replaceAll('l','ᓗ').replaceAll('m','ᒪ').replaceAll('n','ᓴ').replaceAll('o','ᓕ').replaceAll('p','ᔨ').replaceAll('q','ᖏ').replaceAll('r','ᑭ').replaceAll('s','ᐅ').replaceAll('t','ᑎ').replaceAll('u','ᒥ').replaceAll('v','ᑲ').replaceAll('w','ᐃ').replaceAll('x','ᐊ').replaceAll('y','ᓯ').replaceAll('z','ᖓ').replaceAll('â','ᑖ').replaceAll('Œ','ᒌ').replaceAll('μ','ᒫ').replaceAll('†','ᑏ').replaceAll('√','ᑳ').replaceAll('∫','ᑖ').replaceAll('0','ᔾ').replaceAll('1','ᖕ').replaceAll('2','ᑉ').replaceAll('3','ᕐ').replaceAll('4','ᒃ').replaceAll('5','ᑦ').replaceAll('6','ᖅ').replaceAll('7','ᒻ').replaceAll('8','ᓐ').replaceAll('9','ᓪ')
    return word.replaceAll('!','1').replaceAll('@','2').replaceAll('#','3').replaceAll('[$]','4').replaceAll('%','5').replaceAll('&','7').replaceAll('[*]','8').replaceAll("[(]",'9').replaceAll("[)]",'0').replaceAll('G','(').replaceAll('H',')').replaceAll('¡','!').replaceAll('V','?')
}