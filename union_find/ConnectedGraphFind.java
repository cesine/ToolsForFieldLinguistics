/**
 * O end behaviour:
 *
 * - Initialize = N
 * - Modify nodes = N
 * - Query = 1
 * 
 */
public class ConnectedGraphFind {

  private int[] id;
  public static boolean protectUserFromThemSelves = true;

  public ConnectedGraphFind(int N) {
    if (protectUserFromThemSelves && N > 9999) {
      System.out.println("WARNING: This algorithm should not be used on large data sets.");
      return;
    }

    id = new int[N];
    for (int i = 0; i < N; i++) {
      id[i] = i;
    }
  }

  /**
   * Find the root (parent) of a given node
   * 
   * @param  {[type]} int i             [description]
   * @return {[type]}     [description]
   */
  public int root(int i) {
    while (i != id[i] /* if the parent is the same as the sought item, then we are done. */ ) {
      i = id[i];
    }
    return i;
  }


  public boolean connected(int p, int q) {
    if (id == null || id.length < p || id.length < q) {
      return false;
    }

    return root(p) == root(q);
  }

  /**
   * This runs in logN time
   * 
   * @param  {int} p             a node to connect
   * @param  {int} q             another node to connect
   * @return {int}     false if it refuses to run the operation
   */
  public boolean union(int p, int q) {
    if (id == null || id.length < p || id.length < q) {
      return false;
    }

    int i = root(p);
    int j = root(q);

    id[i] = j;
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
