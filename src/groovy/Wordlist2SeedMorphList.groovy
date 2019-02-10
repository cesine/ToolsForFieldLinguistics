
def initials = []
def medials = []
def finals = []
//Inuktitut seeds:
if (language =="InuktitutRomanized"){
	initials = ["isuma", "kati", "tusaa", "mali", "malik", "tiki", "tikit", "nuna"]
	medials = ["sima", "laur", "lauq", "nngit", "vallia"]
	finals = ["juq", "tugut", "mik"]
}
else{
	initials = ["re", "de", "un","pre"]
	medials = ["turn","pronounce","do","say","present"]
	finals = ["ed", "ly", "ness","al","ing","s"]
}

def seeds = [initials,medials,finals]
return seeds