//set up the hash which will contain precedence rules and counts with default of 0
def precedencerelations = [:].withDefault { k -> 0 }

def initials = seeds[0]
def medials = seeds[1]
def finals = seeds[2]

/*
 * Initials are 
 *  1: word initial
 *  2: precede medials
 *  3: precede finals (design choice)
 */
for (initial in initials){
	//add it as an initial, say it proceeds the medials
	precedencerelations["@ > ${initial}"]++
	for (med in medials){
		//say that that initial proceeds all medials
		precedencerelations["${initial} > ${med}"]++
	}
//	design choice 
//	for (fin in finals){
//		//say that that initial proceeds all finals
//		precedencerelations["${initial} > ${fin}"]++
//	}
}
/*
 * Medials are
 *  1: before finals
 */
for (med in medials){
	for (fin in finals){
		//say that that medials proceeds all finals
		precedencerelations["${med} > ${fin}"]++
	}
	//don't claim that medials can end a word.
	//precedencerelations["${med} > @"]++
}
/*
 * Finals are 
 * 1: at the end of the word
 */
for (fin in finals){
	precedencerelations["${fin} > @"]++
}

return precedencerelations