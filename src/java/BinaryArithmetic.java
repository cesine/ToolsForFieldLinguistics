// // "101" "010" -> "111"

// // "101" "011" -> "1000"

public class BinaryArithmetic {

  static String addBinaryStrings(String a, String b) {
    int maxLength = Math.max(a.length(), b.length());
    char[] result = new char[maxLength]; // initialize? 

    //   int previousResult = 0; //itterate using a window of relevant info
    //   for (int previous = maxLength -2; previous >= 0; previous-2){
    //     int current = previous +1;

    //     char acurrent = '0';
    //     char bcurrent = '0';

    //     if (a.length < current){
    //       acurrent = a.charAt(current);
    //     }
    //     if (b.length < current){
    //       bcurrent = b.charAt(current);
    //     }
    //     int sum = addChar(acurrent, bcurrent);

    //     if (sum > 2) {
    //       result[current] = '1';
    //      previousResult = addChar( (char) previous + '1';
    //     } if (sum == 1) {
    //       result[current] = '1';
    //     } else if (){
    //       result[current] = '0';
    //     }


    //     previousResult = current;
    return String.valueOf(result);
  }

  static int addChar(char a, char b) throws Exception {
    if ((a != '0' && a != '1') || (b != '0' && b != '1')) {
      throw new Exception("Invalid input, use 0 or 1");
    }

    if (a == '0' && b == '0') {
      return 0;
    } else if (a == '0' && b == '1' || a == '1' && b == '0') {
      return 1;
    } else if (a == '1' && b == '1') {
      return 2;
    }
    return 0;
  }



  // // something(current, positionofcarry){

  // //   if(pofsitionofcarry!= null){
  // //     done
  // //   }
  // //   something(positionofcarry, psotionofcarry--)

  // // }
  // 
}
