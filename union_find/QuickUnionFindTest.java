public class QuickUnionFindTest {

  static int size = 4;

  public static void itShouldConstruct() {
    QuickUnionFind world = new QuickUnionFind(size);
    System.out.println("Created world size: " + size + " : " + world);

  }

  public static void itShouldKnowIfTwoNodesAreConnected() {
    QuickUnionFind world = new QuickUnionFind(size);
    boolean connected = world.connected(1, 3);
    assert connected == false;
    System.out.println("1 and 3 are connected? " + connected + " " + world);

  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs: ");

    itShouldConstruct();
    itShouldKnowIfTwoNodesAreConnected();

    System.out.println("Done\n");
  }
}
