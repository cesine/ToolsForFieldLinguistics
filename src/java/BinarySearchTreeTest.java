public class BinarySearchTreeTest {


  public static void itShouldConstruct() {
    System.out.println("\nitShouldConstruct ");
    BinarySearchTree tree = new BinarySearchTree();
  }

  public static void itShouldCreateNodes() {
    System.out.println("\nitShouldCreateNodes ");
    BinarySearchTree.Node node = new BinarySearchTree.Node();
    assert node != null;
  }

  public static void itShouldAddNodesInBallencedOrder() {
    System.out.println("\nitShouldAddNodesInBallencedOrder ");
    BinarySearchTree tree = new BinarySearchTree();
    tree.add("p", null);
    System.out.println("Root: " + tree.getRoot().getKey());
    assert "p".equals(tree.getRoot().getKey());
    // assert tree.size() == 1;

    tree.add("n", null);
    System.out.println("Root left: " + tree.getRoot().getLeft().getKey());
    assert "n".equals(tree.getRoot().getLeft().getKey());

    tree.add("r", null);
    System.out.println("Root right: " + tree.getRoot().getRight().getKey());
    assert "r".equals(tree.getRoot().getRight().getKey());

    int height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 1;


    tree.add("m", null);
    System.out.println("Root left: " + tree.getRoot().getLeft().getLeft().getKey());
    assert "m".equals(tree.getRoot().getLeft().getLeft().getKey());

    tree.add("o", null);
    System.out.println("Root right: " + tree.getRoot().getLeft().getRight().getKey());
    assert "o".equals(tree.getRoot().getLeft().getRight().getKey());

    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 2;


    tree.add("q", null);
    System.out.println("Root left: " + tree.getRoot().getRight().getLeft().getKey());
    assert "q".equals(tree.getRoot().getRight().getLeft().getKey());

    tree.add("s", null);
    System.out.println("Root right: " + tree.getRoot().getRight().getRight().getKey());
    assert "s".equals(tree.getRoot().getRight().getRight().getKey());

    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 2;
  }

  public static void itShouldAddNodesInUnballencedOrder() {
    System.out.println("\nitShouldAddNodesInUnballencedOrder ");
    BinarySearchTree tree = new BinarySearchTree();
    tree.add("a", null);
    System.out.println("Root: " + tree.getRoot().getKey());
    assert "a".equals(tree.getRoot().getKey());
    // assert tree.size() == 1;

    tree.add("b", null);
    System.out.println("Root right: " + tree.getRoot().getRight().getKey());
    assert "a".equals(tree.getRoot().getKey());
    assert "b".equals(tree.getRoot().getRight().getKey());

    tree.add("c", null);
    System.out.println("Root right right: " + tree.getRoot().getRight().getRight().getKey());
    assert "c".equals(tree.getRoot().getRight().getRight().getKey());

    int height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 2;
  }

  public static void itShouldAddNodesInMixedOrder() {
    System.out.println("\nitShouldAddNodesInMixedOrder ");
    BinarySearchTree tree = new BinarySearchTree();

    // create a long branch
    tree.add("a", null);
    System.out.println("Root: " + tree.getRoot().getKey());
    assert "a".equals(tree.getRoot().getKey());

    tree.add("c", null);
    System.out.println("Root right: " + tree.getRoot().getRight().getKey());
    assert "a".equals(tree.getRoot().getKey());
    assert "c".equals(tree.getRoot().getRight().getKey());

    tree.add("d", null);
    System.out.println("Root right right: " + tree.getRoot().getRight().getRight().getKey());
    assert "d".equals(tree.getRoot().getRight().getRight().getKey());

    tree.add("e", null);
    System.out.println("Root right right right: " + tree.getRoot().getRight().getRight().getRight().getKey());
    assert "e".equals(tree.getRoot().getRight().getRight().getRight().getKey());

    tree.add("p", null);
    System.out.println("Root right right right right: " + tree.getRoot().getRight().getRight().getRight().getRight().getKey());
    assert "p".equals(tree.getRoot().getRight().getRight().getRight().getRight().getKey());

    int height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 4;

    // add full tree on the bottom
    tree.add("p", null);
    tree.add("n", null);
    tree.add("r", null);
    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 5;

    tree.add("m", null);
    tree.add("o", null);
    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 6;

    tree.add("q", null);
    tree.add("s", null);
    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 6;

    // add on branch on top
    tree.add("b", null);
    height = tree.getHeight();
    System.out.println("Tree height: " + height);
    assert height == 6;
  }

  public static void itShouldFindNodes() {
    System.out.println("\nitShouldFindNodes ");
    BinarySearchTree tree = new BinarySearchTree();
    BinarySearchTree.Node node = new BinarySearchTree.Node("one");

    BinarySearchTree.Node found = tree.find(node);
    assert found == null;

    tree.add(node);
    assert tree.getRoot() == node;
    found = tree.find(node);
    assert found != null;
    System.out.println(" Found via node: "+ found.getKey());

    found = null;
    found = tree.find("one");
    assert found != null;
    System.out.println(" Found via key: "+ found.getKey());

    tree.add("left deeper");
    found = tree.find("left deeper");
    assert found != null;
    System.out.println(" Found left deeper key: "+ found.getKey());

    found = null;
    tree.add("right deeper");
    found = tree.find("right deeper");
    assert found != null;
    System.out.println(" Found right deeper key: "+ found.getKey());
  }

  public static void itShouldRemoveNodes() {
    System.out.println("\nitShouldRemoveNodes ");
    BinarySearchTree tree = new BinarySearchTree();
    BinarySearchTree.Node node = new BinarySearchTree.Node();

    BinarySearchTree.Node removed = tree.remove(node);
    // assert removed != null;
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs for BinarySearchTree: ");

    itShouldConstruct();
    itShouldCreateNodes();

    itShouldFindNodes();
    // itShouldAddNodesInBallencedOrder();
    // itShouldAddNodesInUnballencedOrder();
    // itShouldAddNodesInMixedOrder();

    System.out.println("\nDone \n\n");
  }

}
