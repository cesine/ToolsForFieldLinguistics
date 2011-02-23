/*
         * Expecting a URL in seedString
         * file://localhost/Users/you/Downloads/Kapitalismu%20-%20Wikipidiya.html
         * or
         * http://qu.wikipedia.org/wiki/Kapitalismu
         */
    def serviceMethod(String seedString) {
                String textContent =""
                def seedURL = new URL(seedString)
                textContent = seedURL.getText()
                textContent = textContent.replaceAll(/<p>/,"\nstartpparagraph").replaceAll(/<\/p>/,"\nendpparagraph")
                textContent = textContent.replaceAll(/\n/," ")
                textContent = textContent.replaceAll (/<script[^<]*<\/script>/,"\n")
                textContent = textContent.replaceAll (/<!--[-]*-->/,"\n")
                textContent = textContent.replaceAll(/\n/," ")
                textContent = textContent.replaceAll(/</,'\n<')
                textContent = textContent.replaceAll(/<[^>]*>/,"")
                textContent = textContent.replaceAll(/\n/," ")
                textContent = textContent.replaceAll(/\s\s+/," ")
                textContent = textContent.replaceAll(/startpparagraph/,"\nstartpparagraph ")
                textContent = textContent.replaceAll(/endpparagraph.*$/,"")
                textContent = textContent.replaceAll(/^[^s].*\nstartpparagraph/,"")
                textContent = textContent.replaceAll(/endpparagraph/,"\n").replaceAll(/startpparagraph/,"\n")
                textContent = textContent.replaceAll(/\./,".\n")
                return textContent
    }


