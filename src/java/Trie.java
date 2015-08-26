public class Trie implements Lexicon {

  public static char[] charset = {
    'ბ', 'თ', 'ს', 'მ', 'შ', 'ჯ', 'ა', 'ი', 'უ', 'ო'
  };
  private Trie[] children = new Trie[charset.length];

  public Trie() {
    System.out.println("Constructing");
  }

  public Trie(String[] words) {
    for (int i = 0; i < words.length; i++) {
      add(words[i]);
    }
  }

  @Override
  public boolean add(String word) {
    char first = word.charAt(0);
    int index = findCharSetIndex(first);

    return false;
  }

  @Override
  public boolean remove(String word) {
    return false;
  }

  @Override
  public boolean contains(String word) {
    return false;
  }

  @Override
  public boolean isPrefix(String prefix) {
    return false;
  }

  @Override
  public Object find(String word) {
    return new Object();
  }

  public String toString() {
    return "";
  }

  public static int findCharSetIndex(char character) {
    for (int i = 0; i < charset.length; i++) {
      if (charset[i] == character) {
        return i;
      }
    }
    return -1;
  }

}
