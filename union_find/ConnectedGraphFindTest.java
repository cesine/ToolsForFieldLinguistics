public class ConnectedGraphFindTest {

  static int defaultSize = 4;

  public static void itShouldConstruct() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    System.out.println("  Created world defaultSize: " + defaultSize + " : " + world);
    assert world.toString().equals("[0|1|2|3]");
  }

  public static void itShouldBeAbleToTraceTheRootOfANode() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    int one = world.root(1);
    assert one == 1;
    System.out.println("  Is 1 the root/parent of itself? " + one + " " + world);
  }

  public static void itShouldConnectNodes() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    world.union(1, 3);
    System.out.println("  1 and 3 have the same root? " + world);
    assert world.toString().equals("[0|3|2|3]");
  }

  public static void itShouldKnowIfTwoNodesAreConnected() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    world.union(1, 3);
    boolean connected = world.connected(1, 3);
    assert connected == true;
    System.out.println("  1 and 3 are connected? " + connected + " " + world);
    assert world.toString().equals("[0|3|2|3]");
  }

  public static void itShouldKnowIfTwoNodesAreTransitivelyConnected() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    boolean ranSucessfully = world.union(2, 3);
    assert ranSucessfully == true;
    System.out.println("  Should have 1 and 3 be the same " + world);
    assert world.toString().equals("[0|1|3|3]");

    world.union(1, 2);
    System.out.println("  Should have 1, 2 and 3 be the same " + world);
    assert world.toString().equals("[0|3|3|3]");

    boolean connected = world.connected(1, 3);
    assert connected == true;
    System.out.println("  1 and 3 are transitively connected? " + connected + " " + world);
  }

  public static void itShouldKnowIfTwoNodesAreNotConnected() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    boolean connected = world.connected(1, 3);
    assert connected == false;
    System.out.println("  1 and 3 are not connected? " + connected + " " + world);
    assert world.toString().equals("[0|1|2|3]");
  }

  /**
   * If this is turned on (and the ConnectedGraphFind doesnt prefent this) they you should 
   * get heap space error
   *
   *  Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
   *      at ConnectedGraphFind.<init>(ConnectedGraphFind.java:6)
   *      at ConnectedGraphFindTest.itShouldThrowOutOfMemoryError(ConnectedGraphFindTest.java:25)
   *      at ConnectedGraphFindTest.main(ConnectedGraphFindTest.java:36)
   *      
   * @return {[type]} [description]
   */
  public static void itShouldThrowOutOfMemoryError() {
    ConnectedGraphFind.protectUserFromThemSelves = false;
    assert ConnectedGraphFind.protectUserFromThemSelves == false;
    ConnectedGraphFind world = new ConnectedGraphFind(999999999);
    System.out.println("  Should have thrown an error. ");
    assert world.toString().equals("[0|1|2|3]");
    ConnectedGraphFind.protectUserFromThemSelves = true;
  }

  public static void itShouldComplainIfYouRunUnionOnALargeDataSet() {
    ConnectedGraphFind world = new ConnectedGraphFind(10000);
    boolean ranSucessfully = world.union(1, 3);
    assert ranSucessfully == false;
    System.out.println("  Should still not initialize a larger than toy data set. " + !ranSucessfully + " " + world);
    assert world.toString().equals("");
  }

  public static void itShouldPartiallyRepresentTheGraphParentNodes() {
    System.out.println("  Derivation example");

    ConnectedGraphFind world = new ConnectedGraphFind(10);
    assert world.toString().equals("[0|1|2|3|4|5|6|7|8|9]");

    world.union(1, 0);
    System.out.println("  " + world);
    assert world.toString().equals("[0|0|2|3|4|5|6|7|8|9]");
    world.union(2, 0);
    System.out.println("  " + world);
    assert world.toString().equals("[0|0|0|3|4|5|6|7|8|9]");

    world.union(5, 4);
    System.out.println("\n  " + world);
    assert world.toString().equals("[0|0|0|3|4|4|6|7|8|9]");
    world.union(4, 9);
    System.out.println("  " + world);
    assert(!world.toString().equals("[0|0|0|3|9|9|6|7|8|9]"));
    assert(!world.toString().equals("[0|0|0|3|9|4|6|7|8|9]"));
    assert world.toString().equals("[0|0|0|3|4|4|6|7|8|4]");
    world.union(7, 5);
    System.out.println("  " + world);
    assert(!world.toString().equals("[0|0|0|3|9|4|6|5|8|9]"));
    assert(!world.toString().equals("[0|0|0|3|9|9|6|9|8|9]"));
    assert(!world.toString().equals("[0|0|0|3|9|4|6|9|8|9]"));
    assert world.toString().equals("[0|0|0|3|4|4|6|4|8|4]");
    world.union(6, 8);
    System.out.println("  " + world);
    assert(!world.toString().equals("[0|0|0|3|9|9|8|9|8|9]"));
    assert(!world.toString().equals("[0|0|0|3|9|4|8|9|8|9]"));
    assert world.toString().equals("[0|0|0|3|4|4|8|4|8|4]");
    world.union(9, 8);
    System.out.println("  " + world);
    assert(!world.toString().equals("[0|0|0|3|8|8|8|8|8|8]"));
    assert(!world.toString().equals("[0|0|0|3|9|4|8|9|8|8]"));
    assert(!world.toString().equals("[0|0|0|3|4|4|8|4|8|4]"));
    assert world.toString().equals("[0|0|0|3|4|4|8|4|4|4]");
  }

  public static void itShouldAvoidTallTrees() {
    System.out.println("  Avoid tall trees derivation example");
    ConnectedGraphFind world = new ConnectedGraphFind(10);
    assert world.toString().equals("[0|1|2|3|4|5|6|7|8|9]");

    world.union(4, 3);
    world.union(3, 8);
    world.union(6, 5);
    world.union(9, 4);
    world.union(2, 1);
    world.union(5, 0);
    world.union(7, 2);
    world.union(6, 1);
    world.union(7, 3);
    System.out.println("  " + world);
    assert(!world.toString().equals("[1|8|1|8|3|0|5|1|8|8]"));
    String lessThanEqualsUnion = "[6|2|6|4|6|6|6|2|4|4]";
    assert(!world.toString().equals(lessThanEqualsUnion));
    String greaterThanEqualsUnion = "[5|1|1|1|3|1|5|1|3|3]";
    assert world.toString().equals(greaterThanEqualsUnion);
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");


    itShouldConstruct();
    itShouldBeAbleToTraceTheRootOfANode();

    itShouldConnectNodes();

    itShouldKnowIfTwoNodesAreConnected();
    itShouldKnowIfTwoNodesAreTransitivelyConnected();
    itShouldKnowIfTwoNodesAreNotConnected();

    // itShouldThrowOutOfMemoryError();
    itShouldComplainIfYouRunUnionOnALargeDataSet();

    itShouldPartiallyRepresentTheGraphParentNodes();
    itShouldAvoidTallTrees();

    System.out.println("Done\n");
  }
}
