public class BinarySearchTreeTest {


  public static void itShouldConstruct() {
    BinarySearchTree tree = new BinarySearchTree();
  }

  public static void itShouldCreateNodes() {
    BinarySearchTree.Node node = new BinarySearchTree.Node();
    assert node != null;
  }

  public static void itShouldAddNodes() {
    BinarySearchTree tree = new BinarySearchTree();
    tree.add("b", null);
    System.out.println("Root: " + tree.getRoot().getKey());
    assert "b".equals(tree.getRoot().getKey());
    // assert tree.size() == 1;

    tree.add("a", null);
    System.out.println("Root: " + tree.getRoot().getKey());
    assert "b".equals(tree.getRoot().getKey());

    System.out.println("Root left: " + tree.getRoot().getLeft().getKey());
    assert "a".equals(tree.getRoot().getLeft().getKey());

    tree.add("c", null);
    System.out.println("Root right: " + tree.getRoot().getRight().getKey());
    assert "c".equals(tree.getRoot().getRight().getKey());
  }

  public static void main(String[] args) {
    System.out.println("\nRunning specs for BinarySearchTree: ");

    itShouldConstruct();
    itShouldCreateNodes();

    itShouldAddNodes();

    System.out.println("\nDone \n\n");
  }

}
