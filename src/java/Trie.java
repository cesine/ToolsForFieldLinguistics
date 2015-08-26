public class Trie implements Lexicon {

  public static char[] charset = {
    'ბ', 'თ', 'ს', 'მ', 'შ', 'ჯ', 'ა', 'ი', 'უ', 'ო'
  };
  private Trie[] children = new Trie[charset.length];
  private int numberOfBranches = 0;
  private boolean isFreeMorpheme = false;

  public Trie() {
    // System.out.println("Constructing");
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
    if (index < 0) {
      System.out.println("You requested a word which is outside the character set which this Lexicon supports :(\n\t" + word);
      return false;
    }

    System.out.println("Adding: " + word);
    Trie child = children[index];

    // If there is no Trie at that index yet, then add one.
    if (child == null) {
      child = new Trie();
      children[index] = child;
      numberOfBranches++;
    }

    if (word.length() == 1) {
      if (child.isFreeMorpheme) {
        System.out.println(" Already knew " + word);
        return false;
      }
      child.isFreeMorpheme = true;
      return true;
    } else {
      // recurse
      return child.add(word.substring(1));
    }
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
    if (numberOfBranches == 0) {
      return "";
    }
    String asString = "\n|\n";
    for (int i = 0; i < charset.length; i++) {
      if (children[i] != null) {
        asString += charset[i];
        asString += children[i].toString();
      }
    }
    return asString;
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
