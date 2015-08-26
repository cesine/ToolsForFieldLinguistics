public class TrieTest {

  static String[] defaultVocab = {"ბათუმი", "ბათუმში","ბათუმ"};

  public static void itShouldConstruct() {
    Trie vocab = new Trie();
    System.out.println("  Created empty vocab: " + vocab);
    assert vocab.toString().equals("");
  }

  public static void itShouldConstructWithArrayOfWords() {
    Trie vocab = new Trie(defaultVocab);
    System.out.println("  Created default vocab: " + defaultVocab.length + " : " + vocab);
    assert vocab.toString().equals("");
  }


  public static void itShouldBeAbleToAddWords() {
    Trie vocab = new Trie();
    vocab.add("ბათუმი");
    System.out.println("  Vocab: " + vocab);
    assert vocab.toString().equals("");
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();
    itShouldConstructWithArrayOfWords();

    System.out.println("Done\n");
  }
}
