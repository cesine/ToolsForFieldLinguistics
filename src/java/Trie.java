
public class Trie implements Lexicon{

  public Trie() {
    System.out.println("Constructing");
  }

  @Override
  public boolean add(String word){
    return false;
  }

  @Override
  public boolean remove(String word){
    return false;
  }

  @Override
  public boolean contains(String word){
    return false;
  }

  @Override
  public boolean isPrefix(String prefix){
    return false;
  }

  @Override
  public Object find(String word){
    return new Object();
  }

  public String toString(){
    return "";
  }

}
