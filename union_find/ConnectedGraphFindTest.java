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
    assert world.toString().equals("[0|0|0|3|9|4|6|7|8|9]");
    world.union(7, 5);
    System.out.println("  " + world);
    assert !world.toString().equals("[0|0|0|3|9|4|6|5|8|9]");
    assert world.toString().equals("[0|0|0|3|9|4|6|9|8|9]");
    world.union(6, 8);
    System.out.println("  " + world);
    assert world.toString().equals("[0|0|0|3|9|4|8|9|8|9]");
    world.union(9, 8);
    System.out.println("  " + world);
    assert world.toString().equals("[0|0|0|3|9|4|8|9|8|8]");
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");


    itShouldConstruct();
    itShouldBeAbleToTraceTheRootOfANode();

    itShouldKnowIfTwoNodesAreConnected();
    itShouldKnowIfTwoNodesAreTransitivelyConnected();
    itShouldKnowIfTwoNodesAreNotConnected();

    // itShouldThrowOutOfMemoryError();
    itShouldComplainIfYouRunUnionOnALargeDataSet();

    itShouldPartiallyRepresentTheGraphParentNodes();

    System.out.println("Done\n");
  }
}
