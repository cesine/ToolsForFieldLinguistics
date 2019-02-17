/**
 * Given an array of integers, return a new array of integers of the same size
 * where each number in the array is replaced with the product of all numbers
 * in the array except itself.
 *
 * For example: given the lists [1,2,3,4], the function
 * should return [2*3*4, 1*3*4, 1*2*4, 1*2*3] -> [24, 12, 8, 6].
 *
 * @param  {Array} input Array of integers
 * @return {Array}       Array of integers
 */
function productExceptIndex(input) {
  var i;
  // Accumulate products of values to the right
  var right = [1];
  for (i = input.length - 1; i > 0; i--) {
    right.unshift(right[0] * input[i]);
  }
  console.log('right', right);

  // Accumulate products of values to the left
  var left = [1];
  for (i = 0; i < input.length - 1; i++) {
    left.push(left[i] * input[i]);
  }
  console.log('left', left);

  // Multiply right and left
  return input.map(function(val, i) {
    return right[i] * left[i];
  });
};

describe('Accumulation', function() {
  it('should return [24, 12, 8, 6]', function() {
    var result = productExceptIndex([1, 2, 3, 4]);
    expect(result).toEqual([24, 12, 8, 6]);
  });

  it('should support arbitrary numbers', function() {
    var result = productExceptIndex([9, 22, 13, 8, 1, 3]);
    expect(result).toEqual([6864, 2808, 4752, 7722, 61776, 20592]);
  });

  it('should support zero', function() {
    var result = productExceptIndex([9, 22, 8, 1, 0]);
    expect(result).toEqual([0, 0, 0, 0, 1584]);
  });
});
