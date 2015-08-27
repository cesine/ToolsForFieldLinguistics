public class BinaryArithmeticTest {

  public static void itShouldBeAbleToAddBinaryStrings(){
    String result = BinaryArithmetic.addBinaryStrings("0","0");
    System.out.println(" Added strings 0 and 0: "+ result);
    assert result != null;
  }


  public static void itShouldBeAbleToAddChar(){
    int result = BinaryArithmetic.addChar('0','0');
    System.out.println(" Added chars 0 and 0: "+ result);
    assert result ==0;
  }


  public static void main(String[] args) {
    System.out.println("\nRunning specs for BinaryArithmetic: ");


    itShouldBeAbleToAddBinaryStrings();
    itShouldBeAbleToAddChar();

    System.out.println("\nDone \n\n");
  }

}
