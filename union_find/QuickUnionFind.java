/**
 * O end behaviour:
 *
 * - Initialize = N
 * - Modify nodes = N
 * - Query = 1
 * 
 */
public class QuickUnionFind {

  private int[] id;
  public static boolean protectUserFromThemSelves = true;

  public QuickUnionFind(int N) {
    if (protectUserFromThemSelves && N > 9999) {
      System.out.println("WARNING: This algorithm should not be used on large data sets.");
      return;
    }

    id = new int[N];
    for (int i = 0; i < N; i++) {
      id[i] = i;
    }
  }

  public boolean connected(int p, int q) {
    if (id == null || id.length < p || id.length < q) {
      return false;
    }

    return id[p] == id[q];
  }

  /**
   * This requires a loop through all the elements in the graph
   * which is not good if the size of the graph is large. 
   * 
   * @param  {int} p             a node to connect
   * @param  {int} q             another node to connect
   * @return {int}     false if it refuses to run the operation
   */
  public boolean union(int p, int q) {
    if (id == null || id.length < p || id.length < q) {
      return false;
    }

    int pid = id[p];
    int qid = id[q];

    if (protectUserFromThemSelves && id != null && id.length > 9999) {
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
