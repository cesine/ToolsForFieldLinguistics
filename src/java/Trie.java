public class Trie implements Lexicon {

  public static char[] charset = {
    'ბ', 'თ', 'ს', 'მ', 'შ', 'ჯ', 'ა', 'ი', 'უ', 'ო'
    // 'a', 'b', 'c', 'd', 'e', 'f'
  };
  private Trie[] children = new Trie[charset.length];
  private int numberOfBranches = 0;
  private boolean isFreeMorpheme = false;
  String value = "";
  public Trie() {
    // System.out.println("Constructing");
  }

  public Trie(String[] words) {
    for (int i = 0; i < words.length; i++) {
      // System.out.println("Word: ");
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

    // System.out.println("Adding: " + word);
    Trie child = children[index];

    // If there is no Trie at that index yet, then add one.
    if (child == null) {
      child = new Trie();
      children[index] = child;
      child.value = charset[index] + "";
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

  public String longestBranch(int level, String word) {
    String longestWord = "";
    for (int i = 0; i < charset.length; i++) {
      if (level == 0) {
        word = "";
      }
      if (children[i] != null) {
        word +=  value;
        System.out.println(level + ": Looking at " + value);
        if (children[i].isFreeMorpheme) {
          word = word + "" + children[i].value;
          System.out.println(" At a terminal " + word);
          if (word.length() > longestWord.length()) {
            longestWord = word;
          }
        } else {
          String childWord = children[i].longestBranch(level + 1, word);
          if (childWord.length() > longestWord.length()) {
            System.out.println("Child " + childWord + " was longer " + longestWord);
            longestWord = childWord;
          } else {
            System.out.println("Child " + childWord + " was shorter or equal to " + longestWord);
          }
        }
      }
    }
    return longestWord;
  }



  /** 
   * ***** Printing functions *********
   */
  
  public String toString() {
    return toString(0, 0);
  }


  public String toString(int level, int indent) {
    if (numberOfBranches == 0) {
      return ".";
    }
    String thisRow = value;
    for (int i = 0; i < charset.length; i++) {
      if (children[i] != null) {
        thisRow += children[i].toString(level + 1, indent + 2);
      } else {
        // thisRow += ".";
      }
    }
    return thisRow;
  }


  public String toString(int offset) {
    return toStringWrong(offset);
  }

  public String toStringWrong(int offset) {
    if (numberOfBranches == 0) {
      return "";
    }

    String asString = "";
    String thisRow = "";
    String thisRowBranches = "";
    int longestChildString = 0;
    System.out.println("\nbranches" + numberOfBranches);
    // ArrayList < Trie > unexploredBranches = new ArrayList<Trie>();
    // ArrayList < String > unexploredBranchesPrint = new ArrayList<String>();
    for (int i = 0; i < charset.length; i++) {
      if (children[i] != null) {
        String childString = children[i].toString(offset + 2);
        asString = childString + asString;
        if (childString.length() > longestChildString) {
          longestChildString = childString.length();
        }
        // System.out.print(i + "" + charset[i] + pad(offset));
        thisRow = i + "" + charset[i] + pad(offset) + thisRow;
      }
    }

    asString += "\n" + pad(thisRow.length() / 2) + thisRow + "\n";

    thisRowBranches = thisRowBranches + pad(longestChildString / 2);
    for (int i = 0; i < numberOfBranches; i++) {
      if (numberOfBranches == 1) {
        thisRowBranches += "|" + pad(offset);
      } else if (i == 0) {
        thisRowBranches += "\\" + pad(offset);
      } else if (i == numberOfBranches - 1) {
        thisRowBranches += "/" + pad(offset);
      } else if (i < numberOfBranches / 2) {
        thisRowBranches += "\\" + pad(offset);
      } else if (i >= numberOfBranches / 2) {
        thisRowBranches += "/" + pad(offset);
      } else {
        thisRowBranches += "|" + pad(offset);
      }
    }
    asString += thisRowBranches + "\n";
    return asString;
  }
  

  private static String pad(int padding) {
    String spaces = "";
    if (padding < 0) {
      return spaces;
    }
    for (int i = 0; i < padding; i++) {
      spaces += ".";
    }
    return spaces;
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
