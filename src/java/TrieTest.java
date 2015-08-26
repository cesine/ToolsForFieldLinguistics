public class TrieTest {

  static String[] defaultVocab = {
    "ბათუმი", "ბათუმში", "ბათუმ"
  };

  public static void itShouldConstruct() {
    Trie vocab = new Trie();
    System.out.println("  Created empty vocab: " + vocab);
    assert vocab.toString().equals("");
  }

  public static void itShouldConstructWithArrayOfWords() {
    Trie vocab = new Trie(defaultVocab);
    System.out.println("  Created default vocab: " + defaultVocab.length + " : " + vocab);
    // assert vocab.toString().equals("");
  }

  public static void itShouldBeAbleToAddWords() {
    Trie vocab = new Trie();
    boolean added =vocab.add("ბათუმი");
    assert added == true;
    System.out.println("  Vocab: \n" + vocab);
    // assert vocab.toString().equals("");
  }

  public static void itShouldReturnFalseIfWordWasAlreadyAdded() {
    Trie vocab = new Trie();
    vocab.add("ბათუმი");
    System.out.println("  Vocab: \n" + vocab);
    // assert vocab.toString().equals("");

    boolean added = vocab.add("ბათუმი");
    assert added == false;
    System.out.println("  Vocab: \n" + vocab);

    // assert vocab.toString().equals("");
  }


  public static void itShouldRefuseToAddWordsOutsideTheCharset() {
    Trie vocab = new Trie();
    boolean added = vocab.add("english");
    assert added == false;

    System.out.println("  Vocab: \n" + vocab);
    // assert vocab.toString().equals("");
  }


  public static void itShouldBeAbleToFindIndexOfACharacterInASet() {
    int found = Trie.findCharSetIndex('მ');
    assert found == 3;

    found = Trie.findCharSetIndex('a');
    assert found == -1;

    found = Trie.findCharSetIndex(Trie.charset[Trie.charset.length - 1]);
    assert found == Trie.charset.length - 1;
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();
    itShouldConstructWithArrayOfWords();

    itShouldBeAbleToAddWords();
    itShouldReturnFalseIfWordWasAlreadyAdded();
    itShouldRefuseToAddWordsOutsideTheCharset();

    itShouldBeAbleToFindIndexOfACharacterInASet();

    System.out.println("Done\n");
  }

}
