"101" "010" -> "111"

"101" "011" -> "1000"


String addBinaryStrings(String a, String b) {
  int maxLength = Math.max(a.length, b.length);
  char[] result = char[maxLength]; // initialize? 
  
  for (int i = maxLength -1; i >= 0; i--){
   char ahere = '0';
   char bhere = '0';
   
    if(a.length < i){
      ahere = a.charAt(i);
    }
     if(b.length < i){
      bhere = b.charAt(i);
    }
    int sum = addChar(ahere, bhere);
    
    if (sum > 2) {
      result[i] = '1';
      result[i-1] = '1';
    } if (sum == 1) {
      if(result[i-1] == '1'){
      // avoid carrying all the way to the front.
      }
    }



  }
}

static int addChar(char a, char b){
   if (a == '0' && b == '0') {
      return 0;
    } else if (a == '0' && b == '1' || a == '1' && b == '0'){
      return 1;
    } else if (a == '1' && b == '1') {
      return 2;
    }
}




something(current, positionofcarry){

  if(pofsitionofcarry!= null){
    done
  }
  something(positionofcarry, psotionofcarry--)

}
