import java.util.*;

public class BinarySearchTree {
  private Node root;

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
      return x.childrenCount + 1;
    }
  }

  public boolean add(String key) {
    return add(key, null);
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

  public Node find(String key) {
    return find(new Node(key, null));
  }

  public Node find(Node node) {
    if (this.root == null) {
      return null;
    }
    return this.root.find(node);
  }

  public Node remove(String key) {
    return remove(new Node(key, null));
  }

  public Node remove(Node node) {
    if (this.root == null) {
      return null;
    }
    Node removed = this.root.remove(node);
    if (removed == this.root) {
      if (this.root.getLeft() != null) {
        this.root = this.root.getLeft();
        this.root.childrenCount = removed.childrenCount - 1;
      } else if (this.root.getRight() != null) {
        this.root = this.root.getRight();
        this.root.childrenCount = removed.childrenCount - 1;
      } else {
        this.root = null;
      }
      System.out.println(" removed the root who had " + removed.childrenCount + " children");
      // removed.left = null;
      // removed.right = null;
      removed.childrenCount = 0;
    }
    return removed;
  }

  public int getHeight() {
    if (root == null) {
      return 0;
    }
    return root.getHeight();
  }

  public Node getRoot() {
    return root;
  }


  public static class Node {
    private String key;
    private Object value;
    private Node left;
    private Node right;
    private int childrenCount;
    private int depth;

    public Node() {
      this.key = "";
      this.value = new Object();
      this.childrenCount = 0;
    }

    public Node(String key) {
      this.key = key;
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
      if (node == null || node.key == null) {
        return false;
      }
      int compared = this.compareTo(node);
      if (compared == 0) {
        this.value = node.value;
      } else if (compared < 0) {
        if (this.left == null) {
          this.left = node;
          System.out.println("  Added `" + node.key + "` left of `" + this.key + "` ");
        } else {
          this.left.add(node);
        }
      } else if (compared > 0) {
        if (this.right == null) {
          this.right = node;
          System.out.println("  Added  `" + this.key + "`'s right `" + node.key + "`");
        } else {
          this.right.add(node);
        }
      }
      this.childrenCount++;
      return true;
    }

    public Node find(String key) {
      return find(new Node(key, null));
    }
    
    public Node find(Node node) {
      if (node == null) {
        return null;
      }

      Node found;
      if (this.key == node.key) {
        return this;
      }

      if (this.left != null) {
        System.out.println("  ldeeper");

        found = this.left.find(node);
        if (found != null) {
          return found;
        }
      }

      if (this.right != null) {
        System.out.println("  rdeeper");
        found = this.right.find(node);
        if (found != null) {
          return found;
        }
      }

      return null;
    }

    public Node remove(Node node) {
      if (node == null || node.key == null) {
        return null;
      }
      Node removed;
      if (node.key.equals(this.key)) {
        return this;
      }
      if (this.left != null) {
        removed = this.left.remove(node);
        if (removed == this.left) {
          if (this.left.getLeft() != null) {
            System.out.println("   Replacing my (" + this.key + ") left: " + this.left.getKey() + " with its left: " + this.left.getLeft().getKey());
            this.left = this.left.getLeft();
            this.left.childrenCount = removed.childrenCount - 1;
          }
          if (this.left.getRight() != null) {
            System.out.println("   Replacing my (" + this.key + ") left: " + this.left.getKey() + " with its right: " + this.left.getRight().getKey());
            this.left = this.left.getRight();
            this.left.childrenCount = removed.childrenCount - 1;
          }
          // removed.left = null;
          // removed.right = null;
          childrenCount--;
          return removed;
        }
      }
      if (this.right != null) {
        removed = this.right.remove(node);
        if (removed == this.right) {
          if (this.right.getLeft() != null) {
            System.out.println("   Replacing my (" + this.key + ") right: " + this.right.getKey() + " with its left: " + this.right.getLeft().getKey());
            this.right = this.right.getLeft();
          }
          if (this.right.getRight() != null) {
            System.out.println("   Replacing my (" + this.key + ") right: " + this.right.getKey() + " with its right: " + this.right.getRight().getKey());
            this.right = this.right.getRight();
          }
          // removed.left = null;
          // removed.right = null;
          childrenCount--;
          return removed;
        }
      }
      return null;
    }

    public int getHeight() {
      int leftHeight = 0;
      int rightHeight = 0;
      if (left != null) {
        System.out.println("  deeper");
        left.depth = this.depth + 1;
        leftHeight = left.getHeight();
      }
      if (right != null) {
        System.out.println("  deeper");
        right.depth = this.depth + 1;
        rightHeight = right.getHeight();
      }
      return Math.max(this.depth, Math.max(leftHeight, rightHeight));
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
}
