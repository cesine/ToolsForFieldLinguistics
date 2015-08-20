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

  /**
   * This requires a loop through all the elements in the graph
   * which is not good if the size of the graph is large. 
   * 
   * @param  {[type]} int p             [description]
   * @param  {[type]} int q             [description]
   * @return {[type]}     [description]
   */
  public boolean union(int p, int q) {
    int pid = id[p];
    int qid = id[q];

    if (id != null && id.length > 9999){
      System.out.println("WARNING: This algorithm should not be used on large data sets.");
      return false;
    }
    for (int i = 0; i < id.length; i++) {
      if (id[i] == pid) {
        id[i] = qid;
      }
    }
    return true;
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
