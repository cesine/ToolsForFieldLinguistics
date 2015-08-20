public class QuickUnionFindTest {

  static int defaultSize = 4;

  public static void itShouldConstruct() {
    QuickUnionFind world = new QuickUnionFind(defaultSize);
    System.out.println("  Created world defaultSize: " + defaultSize + " : " + world);
  }

  public static void itShouldKnowIfTwoNodesAreConnected() {
    QuickUnionFind world = new QuickUnionFind(defaultSize);
    boolean connected = world.connected(1, 3);
    assert connected == false;
    System.out.println("  1 and 3 are connected? " + connected + " " + world);
  }

  /**
   * If this is turned on (and the QuickUnionFind doesnt prefent this) they you should 
   * get heap space error
   *
   *  Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
   *      at QuickUnionFind.<init>(QuickUnionFind.java:6)
   *      at QuickUnionFindTest.itShouldThrowOutOfMemoryError(QuickUnionFindTest.java:25)
   *      at QuickUnionFindTest.main(QuickUnionFindTest.java:36)
   *      
   * @return {[type]} [description]
   */
  public static void itShouldThrowOutOfMemoryError() {
    QuickUnionFind.protectUserFromThemSelves = false;
    assert QuickUnionFind.protectUserFromThemSelves == false;
    QuickUnionFind world = new QuickUnionFind(999999999);
    System.out.println("  Should have thrown an error. ");
    QuickUnionFind.protectUserFromThemSelves = true;
  }

  public static void itShouldComplainIfYouRunUnionOnALargeDataSet() {
    QuickUnionFind world = new QuickUnionFind(10000);
    boolean ranSucessfully = world.union(1, 3);
    assert ranSucessfully == false;
    System.out.println("  Should complain. " + !ranSucessfully);
  }

  public static void itShouldConnectTwoNodes() {
    QuickUnionFind world = new QuickUnionFind(defaultSize);
    boolean ranSucessfully = world.union(1, 3);
    assert ranSucessfully == true;
    System.out.println("  Should have 1 and 3 be the same " + world);

    world.union(2, 3);
    System.out.println("  Should have 1, 2 and 3 be the same " + world);

  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();
    itShouldKnowIfTwoNodesAreConnected();

    // itShouldThrowOutOfMemoryError();
    itShouldComplainIfYouRunUnionOnALargeDataSet();
    itShouldConnectTwoNodes();

    System.out.println("Done\n");
  }
}
