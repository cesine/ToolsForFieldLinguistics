public class TrieTest {

  static String[] defaultVocab = {
    "ბათუმი", "ბათუმში", "ბათუმ", "ბათუმის", "ში"
    // "aba", "abb", "abc", "abd"
    // "aba", "abb", "acd", "ace"
  };

  public static void itShouldConstruct() {
    Trie vocab = new Trie();
    System.out.println("  Created empty vocab: " + vocab);
    // assert vocab.toString().equals("");
  }

  public static void itShouldConstructWithArrayOfWords() {
    Trie vocab = new Trie(defaultVocab);
    System.out.println("  Created default vocab: " + defaultVocab.length + " : \n" + vocab);
    // assert vocab.toString().equals("");
  }

  public static void itShouldBeAbleToAddWords() {
    Trie vocab = new Trie();
    boolean added = vocab.add("ბათუმი");
    assert added == true;
    System.out.println("  Vocab: \n" + vocab);
    // assert vocab.toString().equals("");
  }

  public static void itShouldReturnFalseIfWordWasAlreadyAdded() {
    Trie vocab = new Trie();
    vocab.add("ბათუმი");
    // System.out.println("  Vocab: \n" + vocab);
    // assert vocab.toString().equals("");

    boolean added = vocab.add("ბათუმი");
    assert added == false;
    // System.out.println("  Vocab: \n" + vocab);

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

  public static void itShouldBeAbleToFindTheLongestWord() {
    Trie vocab = new Trie();
    String longest = vocab.longestBranch(0, null);
    System.out.println("  Vocab longest word: " + longest + " : " + vocab + "\n");
    // assert "".equals(longest);

    vocab.add("უუ");
    longest = vocab.longestBranch(0, null);
    System.out.println("  Vocab longest word: " + longest + " : " + vocab + "\n");
    assert longest.length() == 2;

    vocab.add("ააა");
    vocab.add("მში");
    longest = vocab.longestBranch(0, null);
    System.out.println("  Vocab longest word: " + longest + " : " + vocab + "\n");
    assert "მში".equals(longest);
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    // itShouldConstruct();
    // itShouldConstructWithArrayOfWords();

    // itShouldBeAbleToAddWords();
    // itShouldReturnFalseIfWordWasAlreadyAdded();
    // itShouldRefuseToAddWordsOutsideTheCharset();

    // itShouldBeAbleToFindIndexOfACharacterInASet();

    itShouldBeAbleToFindTheLongestWord();

    System.out.println("Done\n");
  }

}
