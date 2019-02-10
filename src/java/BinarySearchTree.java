import java.util.*;

/**
 * O end behaviour:
 *
 * - Initialize = C
 * - Size = C
 * - isEmpty = C
 * 
 * - Height = Log N (worst case is N if its a straight tree)
 * - Add = Log N  (worst case is N if its a straight tree)
 * - Remove = Log N (worst case is 2N if its a straight tree and it needs to be rebuilt on the bottom?)
 * - Query/Find/Modify key = Log N (worst case is N if its a straight tree)
 *
 */
public class BinarySearchTree {
  private Node root;

  public BinarySearchTree() {

  }
  public boolean isEmpty() {
    return size(root) == 0;
  }

  /**
   * Getting the size looks up the count of children of the node. 
   * O (1)
   * @return {[type]} [description]
   */
  public int size() {
    return size(root);
  }

  public int size(Node x) {
    if (x == null) {
      return 0;
    } else {
      return x.size + 1;
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
      // Handle the case where the root was lost.
      System.out.println(" removed the root who had " + removed.size + " children");
      this.root = null;
      if (removed.getLeft() != null) {
        removed.getLeft().size++;
        System.out.println(" The new root will be the left branch size " + removed.getLeft().size);
        this.root = removed.getLeft();
        this.root.depth--;
      }
      if (removed.getRight() != null) {
        if (this.root == null) {
          removed.getLeft().size++;
          System.out.println(" The new root will be the right branch size " + removed.getLeft().size);
          this.root = removed.getRight();
          this.root.depth--;
        } else {
          System.out.println(" Adding right branch back");
          this.root.add(removed.getRight());
        }
      }
      removed.left = null;
      removed.right = null;
      // removed.size = 0;
    }
    return removed;
  }

  public int getHeight() {
    if (root == null) {
      return 0;
    }
    return root.getHeight() + 1;
  }

  public Node getRoot() {
    return root;
  }


  public static class Node {
    private String key;
    private Object value;
    private Node left;
    private Node right;
    private int size;
    private int depth;

    public Node() {
      this.key = "";
      this.value = new Object();
      this.size = 0;
    }

    public Node(String key) {
      this.key = key;
      this.size = 0;
    }

    public Node(String key, Object value) {
      this.key = key;
      this.value = value;
      this.size = 0;
    }

    public Node(String key, Object value, int N) {
      this.key = key;
      this.value = value;
      this.size = N;
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
      this.size++;
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
      Node removed = null;
      System.out.println("Removing " + node.getKey());
      if (node.key.equals(this.key)) {
        return this;
      }
      if (this.left != null) {
        removed = this.left.remove(node);
        if (removed != null) {
          System.out.println("emptying my left");
          this.size -= removed.size;
          this.left = null;
        }
      }
      if (removed == null && this.right != null) {
        removed = this.right.remove(node);
        if (removed != null) {
          System.out.println("emptying my right");
          this.size -= removed.size;
          this.right = null;
        }
      }
      if (removed != null) {
        if (removed.getLeft() != null) {
          Node leftTree = removed.getLeft();
          leftTree.depth = 0;
          removed.left = null;
          System.out.println("   Adding my (" + this.key + ") child " + removed.getKey() + " left children: " + leftTree.getKey());
          this.add(leftTree);
          // removedsize = removed.size - 1;
        }
        if (removed.getRight() != null) {
          Node rightTree = removed.getRight();
          rightTree.depth = 0;
          removed.right = null;
          System.out.println("   Adding my (" + this.key + ") child " + removed.getKey() + " right children: " + rightTree.getKey());
          this.add(rightTree);
          // removedsize = removed.size - 1;
        }
        // removed.left = null;
        // removed.right = null;
        size--;
        return removed;
      }
      return null;
    }

    public int getHeight() {
      int leftHeight = 0;
      int rightHeight = 0;
      if (left != null) {
        System.out.println(this.depth + "  ldeeper" + key);
        left.depth = this.depth + 1;
        leftHeight = left.getHeight();
      }
      if (right != null) {
        System.out.println(this.depth + "  rdeeper" + key);
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
