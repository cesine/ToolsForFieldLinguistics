public class TrieTest {

  static int defaultSize = 4;

  public static void itShouldConstruct() {
    Trie vocab = new Trie();
    System.out.println("  Created vocab defaultSize: " + defaultSize + " : " + vocab);
    assert vocab.toString().equals("");
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();

    System.out.println("Done\n");
  }
}
