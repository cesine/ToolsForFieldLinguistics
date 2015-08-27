import java.util.Arrays;

// // "101" "010" -> "111"
// // "101" "011" -> "1000"

public class BinaryArithmetic {

  /**
   * minimal time is going to be max length of one of the string 
   * x2 because of initialization and conversion to string
   */
  static String addBinaryStrings(String a, String b) throws Exception {
    int alength = a.length();
    int blength = b.length();

    int maxLength = Math.max(alength, blength) + 1;
    int[] result = new int[maxLength]; // initialize? 
    System.out.println("Adding to a max length of " + maxLength);
    for (int i = 0; i < maxLength; i++) {
      result[i] = 0;
    }

    //itterate using a window of relevant info
    int previousResult = 0;
    for (int current = maxLength - 1; current >= 0; current--) {
      int previous = current - 1;
      if (previous < -1) {
        break;
      }
      System.out.println("Working on " + previous + " and " + current);
      char acurrent = '0';
      char bcurrent = '0';

      if (alength > current) {
        acurrent = a.charAt(current);
      }
      if (blength > current) {
        bcurrent = b.charAt(current);
      }
      System.out.println("Sum of " + acurrent + " + " + bcurrent + " =");
      int sum = addChar(acurrent, bcurrent) + previousResult;
      System.out.println("     = " + sum);
      if (sum == 3) {
        result[current] = 1;
        previousResult = 1;
        System.out.println(" Carrying further " + previousResult);
      } else if (sum == 2) {
        result[current] = 0;
        previousResult = 1;
        System.out.println(" Carrying " + previousResult);
      } else {
        result[current] = sum;
        previousResult = 0;
      }
    }

    //     previousResult = current;
    // Convert array of ints into its string value
    String asString = "";
    if (previousResult == 1) {
      asString += "1";
    }
    for (int i = 0; i < maxLength; i++) {
      if (i == maxLength - 1 && result[i] == 0) {
        continue;
      }
      asString += result[i];
    }
    return asString;
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
