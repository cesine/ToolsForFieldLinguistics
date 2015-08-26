
public class Trie implements Lexicon {

  private char[] charset = {
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

}
