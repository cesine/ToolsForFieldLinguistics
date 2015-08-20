public class ConnectedGraphFindTest {

  static int defaultSize = 4;

  public static void itShouldConstruct() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    System.out.println("  Created world defaultSize: " + defaultSize + " : " + world);
  }

  public static void itShouldBeAbleToTraceTheRootOfANode() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    int one = world.root(1);
    assert one == 1;
    System.out.println("  Is 1 the root/parent of itself? " + one + " " + world);
  }

  public static void itShouldKnowIfTwoNodesAreConnected() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    boolean connected = world.connected(1, 3);
    assert connected == false;
    System.out.println("  1 and 3 are connected? " + connected + " " + world);
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
    ConnectedGraphFind.protectUserFromThemSelves = true;
  }

  public static void itShouldComplainIfYouRunUnionOnALargeDataSet() {
    ConnectedGraphFind world = new ConnectedGraphFind(10000);
    boolean ranSucessfully = world.union(1, 3);
    assert ranSucessfully == false;
    System.out.println("  Should complain. " + !ranSucessfully);
  }

  public static void itShouldConnectTwoNodes() {
    ConnectedGraphFind world = new ConnectedGraphFind(defaultSize);
    boolean ranSucessfully = world.union(1, 3);
    assert ranSucessfully == true;
    System.out.println("  Should have 1 and 3 be the same " + world);

    world.union(2, 3);
    System.out.println("  Should have 1, 2 and 3 be the same " + world);
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();
    itShouldBeAbleToTraceTheRootOfANode();
    itShouldKnowIfTwoNodesAreConnected();

    // itShouldThrowOutOfMemoryError();
    itShouldComplainIfYouRunUnionOnALargeDataSet();
    itShouldConnectTwoNodes();

    System.out.println("Done\n");
  }
}
