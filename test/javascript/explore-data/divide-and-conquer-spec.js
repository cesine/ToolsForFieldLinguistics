var debug = function() {
  for (var arg in arguments) {
    console.log(arguments[arg]);
  }
  return;
};

/**
 * Merge two arrays (can have different length)
 *
 * O: N
 *
 * @param  {Array} a Array of numbers
 * @param  {Array} b Array of numbers
 * @return {Array}   Array of numbers
 */
function merge(a, b) {
  var result = [];
  var k = a.length + b.length;
  debug("  merge", a, b, k);
  var i = 0;
  var j = 0;

  for (var position = 0; position <= k-1; position++) {
    debug("  choose " + position + " a: " + a[i] + " b: "+ b[j]);
    if (a[i] < b[j] || (a[i] !== undefined && b[j] === undefined)) {
      result[position] = a[i];
      debug("           a: " + a[i]);
      i++;
    } else if (b[j] !== undefined) {
      result[position] = b[j];
      debug("                 b:" + b[j]);
      j++;
    }
  }
  debug("   merged", result);
  return result;
}

/**
 * Merge sort an array
 *
 * O: N log(N)
 *
 * @param  {Array} a An array to sort
 * @return {Array}   The sorted array
 */
function mergeSort(a) {
  var firstEnd = Math.ceil(a.length / 2);
  if (!a || a.length < 2) {
    // debug(' too short', a);
    return a;
  }
  debug("\nLength: ", firstEnd);

  var part1 = a.slice(0, firstEnd);
  var part2 = a.slice(firstEnd, a.length);
  debug("part 1", part1);
  debug("part 2", part2);
  return merge(mergeSort(part1), mergeSort(part2));
}

function selectionSort() {}

function insertionSort() {}

function bubbleSort() {}

describe("divide and conquer", function() {
  describe("mergeSort", function() {
    it("should handle the base case", function() {
      var result = mergeSort([1]);
      expect(result).toEqual([1]);
    });

    it("should sort distinct numbers", function() {
      var result = mergeSort([5, 4, 1, 8, 7, 2, 6, 9]);
      debug("result", result);
      expect(result).toEqual([1, 2, 4, 5, 6, 7, 8, 9]);
    });

    it("should sort non distinct numbers", function() {
      var result = mergeSort([5, 4, 1, 9, 7, 1, 6, 9]);
      debug("result", result);
      expect(result).toEqual([1, 1, 4, 5, 6, 7, 9, 9]);
    });

    it("should sort distant numbers", function() {
      var result = mergeSort([33, 4, 0, 782323, 9]);
      debug("result", result);
      expect(result).toEqual([0, 4, 9, 33, 782323]);
    });

    it("should sort inversed numbers", function() {
      var result = mergeSort([11, 8, 4, 3, 2, 1, 0]);
      debug("result", result);
      expect(result).toEqual([0, 1, 2, 3, 4, 8, 11]);
    });
  });
});
