import java.util.regex.Pattern
import java.util.regex.Matcher


def target= """==Visualizations==
===Connected Graphs===
Connected graphs are used to navigate and zoom in and out on sections when the data is highly connected, and not very heirarchical. 
====Trees====
Trees are used when the data is heirarchical, or taxonomical. This is often the easiest visualization to understand. 

===Tag Clouds===
Tag clouds help get an idea of the popularity of word, or a concept depending on how the algorithm is designed. Great for histograms, see also bell shapped curves...

"""
def resultString=""
def header2 = "/==([^=]*)==/"
def header3 = "^====(.*)===="
def header4 = "^=====(.*)====="

def workingString =    target.split("\n")
workingString.each{ line ->
  
  if(line.startsWith("=")){
      
      line = line.replaceAll(/=====+([^=]+)=====+/)
       { fullMatch, headline ->
           line = "\n<h5>"+headline+"</h5>"
       }
      
       line = line.replaceAll(/====([^=]+)====/)
       { fullMatch, headline ->
            line = "\n<h4>"+headline+"</h4>"
       }
       line = line.replaceAll(/===([^=]+)===/)
       { fullMatch, headline ->
            line = "\n<h3>"+headline+"</h3>"
       }
       line = line.replaceAll(/==([^=]+)==/)
       { fullMatch, headline ->
            line = "\n<h2>"+headline+"</h2>"
       }
       line.replaceAll(/=([^=]+)=/)
       { fullMatch, headline ->
            line = "\n<h1>"+headline+"</h1>"
       }
    
    }
    resultString = resultString +"\n"+line

}
       
return resultString