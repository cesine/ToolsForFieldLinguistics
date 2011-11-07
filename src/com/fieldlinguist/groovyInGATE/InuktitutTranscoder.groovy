//System.setProperty("file.encoding", "UTF-8");

println(System.properties['file.encoding']);

println "ᓕᖏᖑᒪᕿᓕᐃᕿᑭᓂᓕᓴᓄᑲᖁ"
System.out.println nunacomToUnicode("weciwmoe4")
def  nunacomToUnicode(word){

return word.replaceAll('!','1').replaceAll('#','3').replaceAll('%','5').replaceAll('&','7').replaceAll("[(]",'9').replaceAll("[)]",'0').replaceAll('[*]','8').replaceAll('[/]','ᔭ').replaceAll('[?]','ᕙ').replaceAll('@','2').replaceAll('A','ᒍ').replaceAll('B','ᕼ').replaceAll('C','ᕋ').replaceAll('D','ᕈ').replaceAll('E','ᕆ').replaceAll('F','ᕕ').replaceAll('G','(').replaceAll('H',')').replaceAll('J','ᒧ').replaceAll('J','ᔪ').replaceAll('K','ᕗ').replaceAll('M','ᓚ').replaceAll('N','ᓇ').replaceAll('Q','ᒋ').replaceAll('S','ᐳ').replaceAll('W','ᐱ').replaceAll('X','ᐸ').replaceAll('Z','ᒐ').replaceAll('^','6').replaceAll('a','ᖑ').replaceAll('b','ᑕ').replaceAll('c','ᖃ').replaceAll('d','ᖁ').replaceAll('f','ᑯ').replaceAll('g','ᑐ').replaceAll('h','ᓱ').replaceAll('i','ᓂ').replaceAll('j','ᒧ').replaceAll('k','ᓄ').replaceAll('l','ᓗ').replaceAll('m','ᒪ').replaceAll('n','ᓴ').replaceAll('o','ᓕ').replaceAll('q','ᖏ').replaceAll('r','ᑭ').replaceAll('s','ᐅ').replaceAll('t','ᑎ').replaceAll('u','ᒥ').replaceAll('v','ᑲ').replaceAll('w','ᐃ').replaceAll('x','ᐊ').replaceAll('y','ᓯ').replaceAll('z','ᖓ').replaceAll('¡','!').replaceAll('â','ᑖ').replaceAll('Œ','ᒌ').replaceAll('μ','ᒫ').replaceAll('†','ᑏ').replaceAll('‰','‰').replaceAll('√','ᑳ').replaceAll('∫','ᑖ').replaceAll('∫','ᓂ').replaceAll('2','ᑉ').replaceAll('3','ᕐ').replaceAll('4','ᒃ').replaceAll('5','ᑦ').replaceAll('6','ᖅ').replaceAll('7','ᒻ').replaceAll('8','ᓐ').replaceAll('9','ᓪ')

}