public class BinaryArithmeticTest {

  public static void itShouldBeAbleToAddBinaryStrings() {
    String result = BinaryArithmetic.addBinaryStrings("0", "0");
    System.out.println(" Added strings 0 and 0 :" + result+ ":");
    assert result != null;
    assert "0".equals(result);

    result = BinaryArithmetic.addBinaryStrings("0000", "0");
    System.out.println(" should pad the result to the size of the input :" + result+ ":");
    assert "0000".equals(result);
  }

  public static void itShouldBeAbleToAddChar() throws Exception {
    int result = BinaryArithmetic.addChar('0', '0');
    System.out.println(" Added chars 0 and 0: " + result);
    assert result == 0;

    result = BinaryArithmetic.addChar('0', '1');
    System.out.println(" Added chars 0 and 1: " + result);
    assert result == 1;

    result = BinaryArithmetic.addChar('1', '1');
    System.out.println(" Added chars 1 and 1: " + result);
    assert result == 2;

    try {
      System.out.println(" Adding chars e and 1: " + result);
      result = BinaryArithmetic.addChar('d', '1');
      assert result == 0;
      assert false;
    } catch (Exception e) {
      System.out.println("   should throw an exception " );
      assert true;
    }
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs for BinaryArithmetic: ");


    itShouldBeAbleToAddBinaryStrings();
    try {
      itShouldBeAbleToAddChar();
    } catch (Exception e) {
      System.out.println("Unexpected error in itShouldBeAbleToAddChar.");
    }

    System.out.println("\nDone \n\n");
  }

}
