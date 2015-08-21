/**
 * O end behaviour:
 *
 * - Initialize = N
 * - Modify nodes = N 
 * - Query = N (worst case if tree is tall)
 * 
 */
public class ConnectedGraphFind {

  private int[] representation;
  public static boolean protectUserFromThemSelves = true;

  public ConnectedGraphFind(int N) {
    if (protectUserFromThemSelves && N > 9999) {
      System.out.println("WARNING: This algorithm should not be used on large data sets.");
      return;
    }

    representation = new int[N];
    for (int i = 0; i < N; i++) {
      representation[i] = i;
    }
  }

  /**
   * Find the root (parent) of a given node
   * 
   * @param  {[type]} int i             [description]
   * @return {[type]}     [description]
   */
  public int root(int node) {
    if (representation == null || representation.length < node) {
      return -1;
    }

    while (node != representation[node] /* if the parent is the same as the sought item, then we are done. */ ) {
      node = representation[node];
    }
    return node;
  }

  public boolean connected(int p, int q) {
    if (representation == null || representation.length < p || representation.length < q) {
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
    if (representation == null || representation.length < p || representation.length < q) {
      return false;
    }

    int i = root(p);
    int j = root(q);

    representation[i] = j;
    return true;
  }

  public String toString() {
    if (representation == null || representation.length == 0) {
      return "";
    }
    String contents = "[";
    for (int i = 0; i < representation.length; i++) {
      if (i > 0) {
        contents += "|";
      }
      contents += representation[i];
    }
    return contents + "]";
  }

}
