/**
 * O end behaviour:
 *
 * - Initialize = N
 * - Modify nodes = log N (find roots of each node)
 * - Query = log N  (because trees are ballanced)
 * 
 */
public class ConnectedGraphFind {

  private int[] representation;
  private int[] sz;

  public static boolean protectUserFromThemSelves = true;

  public ConnectedGraphFind(int N) {
    if (protectUserFromThemSelves && N > 9999) {
      System.out.println("    WARNING: This algorithm should not be used on data sets larger than ~1.79e8 on heap space of 2GB");
      return;
    }

    representation = new int[N];
    sz = new int[N];
    for (int i = 0; i < N; i++) {
      representation[i] = i;
      sz[i] = 1;
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
      // System.out.println("    node: " + node + " parent: " + representation[node]);
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
   * This runs in logN time. 
   *  - Puts the smaller tree in the larger tree, which makes the larger tree size at least double
   *  - Which can happen at most log N times
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
    if (i == -1 || j == -1) {
      return true;
    }
    if (i == j) {
      return true;
    }
    // System.out.println("    p " + p + " root: " + i + " " + " size  " + sz[i]);
    // System.out.println("    q " + q + " root: " + j + " " + " size  " + sz[j]);

    if (sz[i] > sz[j]) {
      representation[j] = i;
      sz[i] += sz[j];
    } else {
      representation[i] = j;
      sz[j] += sz[i];
    }
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
