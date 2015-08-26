public interface Lexicon {
  boolean add(String word);
  boolean remove(String word);
  boolean isPrefix(String prefix);
  boolean contains(String word);
  Object find(String word);
}
