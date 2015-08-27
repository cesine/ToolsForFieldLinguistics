import java.util.*;

public class BinarySearchTree {
  private Node root;

  public static class Node {
    private String key;
    private Object value;
    private Node left;
    private Node right;
    private int childrenCount;

    public Node() {
      this.key = "";
      this.value = new Object();
      this.childrenCount = 0;
    }

    public Node(String key, Object value) {
      this.key = key;
      this.value = value;
      this.childrenCount = 0;
    }

    public Node(String key, Object value, int N) {
      this.key = key;
      this.value = value;
      this.childrenCount = N;
    }

    public int compareTo(Node anotherNode) {
      if (this.key == null || anotherNode.key == null) {
        return -1;
      }
      System.out.println("  " + this.key + " ? " + anotherNode.key);
      return anotherNode.key.compareTo(this.key);
    }

    public boolean add(Node node) {
      int compared = this.compareTo(node);
      if (compared == 0) {
        this.value = node.value;
      } else if (compared < 0) {
        if (this.left == null) {
          this.left = node;
          System.out.println("  Added `" + node.key + "` left of `" + this.key + "` ");
          this.childrenCount++;
        } else {
          this.left.add(node);
        }
      } else if (compared > 0) {
        if (this.right == null) {
          this.right = node;
          System.out.println("  Added  `" + this.key + "`'s right `" + node.key +"`");
          this.childrenCount++;
        } else {
          this.right.add(node);
        }
      }
      return true;
    }

    public String getKey() {
      return this.key;
    }

    public Node getLeft() {
      return left;
    }
    public Node getRight() {
      return right;
    }
  }

  public BinarySearchTree() {

  }
  public boolean isEmpty() {
    return size(root) == 0;
  }

  public int size() {
    return size(root);
  }

  public int size(Node x) {
    if (x == null) {
      return 0;
    } else {
      return x.childrenCount;
    }
  }

  public boolean add(String key, Object value) {
    Node node = new Node(key, value);
    return add(node);
  }


  public boolean add(String key, Object value, int childCount) {
    Node node = new Node(key, value, childCount);
    return add(node);
  }

  public boolean add(Node node) {
    if (root == null) {
      root = node;
      return true;
    }
    return root.add(node);
  }

  public Node getRoot() {
    return root;
  }

}
