public class QuickUnionFind {
  
  private int[] id;

  public QuickUnionFind(int N) {
    id = new int[N];
    for (int i = 0; i < N; i++) {
      id[i] = i;
    }
  }

  public boolean connected(int p, int q) {
    return id[p] == id[q];
  }

  public String toString() {
    if (id == null || id.length == 0) {
      return "";
    }
    String contents = "[";
    for (int i = 0; i < id.length; i++) {
      if (i > 0) {
        contents += "|";
      }
      contents += id[i];
    }
    return contents + "]";
  }

}
