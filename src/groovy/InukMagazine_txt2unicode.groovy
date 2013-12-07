/*
This file is used to extract text from the InukMagazine pdfs.

It takes all files in a directory which contains wierd strings (hypothesis is that they are most likley nunacom) 
and for each word that looks weird, reincodes it in unicode using a nunacom to unicode transcoder.
The output for each file is saved as an HTML file with each line taged as a <p> for use in GATE.

Expections:
This file will run on the output of
$ pdftotext -enc UTF-8 InukMagazine104.pdf InukMagazine104.txt 

The above line works rather well to pull text out of InukMagazine, 
the only error we have seen so far is that some Inuktitut words get 
cut in the middle, right before a letter. Since a letter is always a 
subscript consonant and no words begin with these letters it is easy 
to reverse these words which were divided in the middle. 


Example:
91  2002
 91  2002
wkw5 iWz5 ckw8q5tx3i3j5 Inuit Nipingat Qanuinngittiarnirmut A Voice for Inuit Health La santé des Inuits
 ᐃᓄᐃᑦ ᓂᐱᖓᑦ ᖃᓄᐃᓐᖏᑦᑎᐊᕐᓂᕐᒧᑦ Inuit Nipingat Qanuinngittiarnirmut A Voice for Inuit Health La santé des Inuits
c9l^i4 x QALLUNAANIK Wsy6ysEi6: PIUSIQSIURINIQ : wkw5 Wsy6ys3iq5 inuit piusiqsiurningit c9l^i4 ra9ox qallunaanik kingullia
 ᖃᓪᓗ^ᓂᒃ x QALLUNAANIK ᐱᐅᓯᖅᓯᐅᕆᓂᖅ: PIUSIQSIURINIQ : ᐃᓄᐃᑦ ᐱᐅᓯᖅᓯᐅᕐᓂᖏᑦ inuit piusiqsiurningit ᖃᓪᓗ^ᓂᒃ ᑭᖑᓪᓕᐊ qallunaanik kingullia
Q ALLUNOLOGY : The Inuit Study of Qallunaat Part II
 Q ALLUNOLOGY : The Inuit Study of Qallunaat Part II

srs6 WINTER UKIUQ HIVER
 ᐅᑭᐅᖅ WINTER UKIUQ HIVER
 
wkw5 xgc5b6ym/q8i4 scsyc3i6 • •
 ᐃᓄᐃᑦ ᐊᑐᖃᑦᑕᖅᓯᒪᔭᖏᓐᓂᒃ ᐅᖃᐅᓯᖃᕐᓂᖅ • •
 
GIVING VOICE TO THE INUIT EXPERIENCE I N U I T AT U Q AT TA Q S I M A J A N G I N N I K U Q A U S I Q A R N I Q
 GIVING VOICE TO THE INUIT EXPERIENCE I N U I T AT U Q AT TA Q S I M A J A N G I N N I K U Q A U S I Q A R N I Q
 
L’ E X P R E S S I O N D E L’ E X P É R I E N C E I N U I T E
 L’ E X P R E S S I O N D E L’ E X P É R I E N C E I N U I T E
 
kN 5yxK5
 ᓄᓇᑦᓯᐊᕗᑦ
Our Beautiful Land Nunatsiavut Notre beau pays
 Our Beautiful Land Nunatsiavut Notre beau pays
PM40069916
 PM40069916
n6rb6 • ISSUE • NUMÉRO • SAQQITAQ 104
 ᓴᖅᑭᑕᖅ • ISSUE • ᓇᙵᓚÉᖖᖠ • SAQQITAQ 104
$6.25
 $6.25
o www.itk.ca
 o www.itk.ca

Notes:
    To find out if a file is UTF-8 type:
    $file filenametocheck.txt
    If the files are not UTF-8, you need to convert them before running them through this script.
    To change file encoding in vim :write ++enc=utf-8 

*/


testSystemEncoding()

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
    def path = "${outpath}/${individualfilename.replaceAll('.txt','')}_preprocessed.html"
    OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(path),"UTF-8");
    try{
        out.append "<html>\n"
        def numberToStopTheLoopToShowOnlyPartOfIt = 0                  //(to only run part of the Loop)
        while (true){
            line = sourcefile.readLine()
            numberToStopTheLoopToShowOnlyPartOfIt ++                   //(to only run part of the loop)    
            //if(numberToStopTheLoopToShowOnlyPartOfIt >10 || line == null){ break; }    //(to only run part of the loop)
                
            if (line.length() > 1){
              debugln line
              out.append "<p><pdftotext>${line}</pdftotext><br/>"
              out.append "\n<unicode>"
              def words = line.split(" ")
              for (word in words){
                if( !(word =~ /\d\d/) && !(word == "•") && ((word == "nixi") || (word =~ /[!?][^ ]/) || (word =~ /@[^abcdefghijklmnopqrstuvwxyz]/) || (word =~ /[„‰ß˚∑¿ƒ•˜¬÷©μ†¥√∫˛]/) || (word =~ /[{]$/) || (word =~ /[?#$%¿&*)][^., ]/) || (word =~ /[^\/( \d]\d/) || (word =~ /[^ \/ABCDEÉÈÇFGHIJKLMNOPQRSTUVWXYZ“.('’-][A-Z]/) || (word =~ /[hxqw][b]/) || (word =~ /\d[a-zA-Z][a-zA-Z]/) ) ){
                   try {
                     word = inukMagazineToUnicode(word)
                     //print " : "+ word+" " 
                   }catch(Exception ex) {
                        println( "\n\nProblem with word: "+ex.message)
                   }
                 }
                 /*
                 No inuktitut words start with these letters, if they do it's an error from the pdftotext processing.
                 */
                 if(word ==~ /^[ᖕᑉᕐᒃᑦᖅᒻᓐᓪᔾ].*/){
                     debug ""+word
                     out.append ""+word
                 }else{
                     debug " "+word
                     out.append " "+word
                 }
              }
              out.append "</unicode></p>\n"
              debugln ""
            } 
        }//end loop for lines:
        println "==end of file ${numberToStopTheLoopToShowOnlyPartOfIt} Lines=="
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

def debug(stringToPrint){
    //print stringToPrint
}
def debugln(stringToPrint){
    //println stringToPrint
}

//this is mostly nunacom but there are some exceptions that are unique to the inukmagazines and the pdftotext extraction process
def  inukMagazineToUnicode(word){
        //.replaceAll('^','6')ßᕚᓃÔ~ ᐋᔫ≈„˛˚ ÇÎ∑÷Ï ˆ¬ ƒ© “ ¥ᓰ ˜ᓈ  TODO: [ ωƒœø
    word = word.replaceAll('‰','ᕇ').replaceAll('©','ᑑ').replaceAll('„','ᐲ').replaceAll('Ï','ᕖ').replaceAll('÷','ᔮ').replaceAll('¬','ᓘ').replaceAll('ƒ','ᑰ').replaceAll('∑','ᐄ').replaceAll('˛','ᐹ').replaceAll('Ô','ᔫ').replaceAll('≈','ᐋ').replaceAll('~','ᓵ').replaceAll('[{]','ᔅ').replaceAll('Ç','ᕌ').replaceAll('Î','ᕉ').replaceAll('˚','ᓅ').replaceAll('•','ᓃ').replaceAll('¿','ᕚ').replaceAll('ß','ᐆ').replaceAll('[/]','ᔭ').replaceAll('[?]','ᕙ').replaceAll('A','ᒍ').replaceAll('C','ᕋ').replaceAll('D','ᕈ').replaceAll('E','ᕆ').replaceAll('F','ᕕ').replaceAll('j','ᒧ').replaceAll('I','ᖤ').replaceAll('J','ᔪ').replaceAll('K','ᕗ').replaceAll('L','ᖢ').replaceAll('M','ᓚ').replaceAll('N','ᓇ').replaceAll('O','ᖠ').replaceAll('P','ᖦ').replaceAll('Q','ᒋ').replaceAll('R','ᖖ').replaceAll('S','ᐳ').replaceAll('T','ᙱ').replaceAll('U','ᙵ').replaceAll('V','?').replaceAll('W','ᐱ').replaceAll('X','ᐸ').replaceAll('Y','ᙳ').replaceAll('Z','ᒐ').replaceAll('a','ᖑ').replaceAll('b','ᑕ').replaceAll('c','ᖃ').replaceAll('d','ᖁ').replaceAll('e','ᕿ').replaceAll('f','ᑯ').replaceAll('g','ᑐ').replaceAll('h','ᓱ').replaceAll('i','ᓂ').replaceAll('j','ᒧ').replaceAll('k','ᓄ').replaceAll('l','ᓗ').replaceAll('m','ᒪ').replaceAll('n','ᓴ').replaceAll('o','ᓕ').replaceAll('p','ᔨ').replaceAll('q','ᖏ').replaceAll('r','ᑭ').replaceAll('s','ᐅ').replaceAll('t','ᑎ').replaceAll('u','ᒥ').replaceAll('v','ᑲ').replaceAll('w','ᐃ').replaceAll('x','ᐊ').replaceAll('y','ᓯ').replaceAll('z','ᖓ').replaceAll('â','ᑖ').replaceAll('Œ','ᒌ').replaceAll('μ','ᒫ').replaceAll('†','ᑏ').replaceAll('√','ᑳ').replaceAll('∫','ᑖ').replaceAll('0','ᔾ').replaceAll('1','ᖕ').replaceAll('2','ᑉ').replaceAll('3','ᕐ').replaceAll('4','ᒃ').replaceAll('5','ᑦ').replaceAll('6','ᖅ').replaceAll('7','ᒻ').replaceAll('8','ᓐ').replaceAll('9','ᓪ')
    return word.replaceAll('!','1').replaceAll('@','2').replaceAll('#','3').replaceAll('[$]','4').replaceAll('%','5').replaceAll('&','7').replaceAll('[*]','8').replaceAll("[(]",'9').replaceAll("[)]",'0').replaceAll('G','(').replaceAll('H',')').replaceAll('¡','!').replaceAll('V','?').replaceAll('B','H')
}
def testSystemEncoding(){
		System.setProperty("file.encoding", "UTF-8");
    println("The system encoding is : "+System.properties['file.encoding']+" (If it is not UTF-8, this script will not work as intended) ");
    println "This should look like Inuktitut: ᐊᑐᖃᑦᑕᖅᓯᒪᔭᖏᓐᓂᒃ ᐅᖃᐅᓯᖃᕐᓂᖅ"
    System.out.println "This should also look like Inuktitut: "+ inukMagazineToUnicode("n6rb6")
}
