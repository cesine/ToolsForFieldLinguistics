/**
 * Merge two arrays (can have different length)
 *
 * @param  {Array} a Array of numbers
 * @param  {Array} b Array of numbers
 * @return {Array}   Array of numbers
 */
function merge(a, b) {
  var result = [];
  console.log("  merge", a, b);
  for (var i = 0; i < Math.max(a.length, b.length); i++) {
    if (!a[i]) {
      result.push(b[i]);
    } else if (!b[i]) {
      result.push(a[i]);
    } else if (a[i] < b[i]) {
      result.push(a[i]);
      result.push(b[i]);
    } else {
      result.push(b[i]);
      result.push(a[i]);
    }
  }
  console.log("  merged", result);
  return result;
}

/**
 * Merge sort an array
 * @param  {Array} a An array to sort
 * @return {Array}   The sorted array
 */
function mergeSort(a) {
  var firstEnd = Math.ceil(a.length / 2);
  console.log("\nLength: ", firstEnd);
  if (!a || a.length < 2) {
    // console.log(' too short', a);
    return a;
  }


  var part1 = a.slice(0, firstEnd);
  var part2 = a.slice(firstEnd, a.length);
  console.log("part 1", part1);
  console.log("part 2", part2);
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
      console.log("result", result);
      // 5,4,1,8
      // 7,2,6,3
      // expect(result).toEqual([5, 7, 2, 4, 1, 6, 8]);
      expect(result).toEqual([1, 2, 4, 6, 5, 7, 8, 9]);
    });
  });
});
