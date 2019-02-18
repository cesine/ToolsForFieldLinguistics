var debug = function() {
  // console.log(arguments);
  return;
};

/**
 * Given an array of integers, return a new array of integers of the same size
 * where each number in the array is replaced with the product of all numbers
 * in the array except itself.
 *
 * For example: given the lists [1,2,3,4], the function
 * should return [2*3*4, 1*3*4, 1*2*4, 1*2*3] -> [24, 12, 8, 6].
 *
 * @param  {Array} numbers Array of integers
 * @return {Array}       Array of integers
 */
function productExceptSelfUsingNestedLoops(numbers) {
  var result = [];
  for (var i = 0; i < numbers.length; i++) {
    var accum = 1;

    for (var j = 0; j < numbers.length; j++) {
      if (i === j) {
        continue;
      }
      accum = accum * numbers[j];
    }

    result.push(accum);
  }
  return result;
}

function productExceptSelfUsingNestedMap(numbers) {
  return numbers.map(function(position, i) {
    var accum = 1;

    numbers.forEach(function(other, j) {
      if (i === j) {
        return;
      }
      accum = accum * other;
    });

    return accum;
  });
}

function productExceptSelfUsingNestedReduce(numbers) {
  var initialValue = 1;
  return numbers.map(function(val, i) {
    return numbers.reduce(function(acc, curr, j) {
      if (i === j) {
        return acc;
      }

      return acc * curr;
    }, initialValue);
  });
}

function productExceptSelfLinear(numbers) {
  var i;
  // Accumulate products of values to the right
  var right = [1];
  for (i = numbers.length - 1; i > 0; i--) {
    right.unshift(right[0] * numbers[i]);
  }
  debug("right", right);

  // Accumulate products of values to the left
  var left = [1];
  for (i = 0; i < numbers.length - 1; i++) {
    left.push(left[i] * numbers[i]);
  }
  debug("left", left);

  // Multiply right and left
  return numbers.map(function(val, i) {
    return right[i] * left[i];
  });
}

/**
 * Divide and concur, normal multiplication is n^2
 *
 * @param  {Number} x  Value to multiply
 * @param  {Number} y  Value to multiply
 * @return {Number}    Product
 */
function bruteForceMultiplication(x, y) {
  var yDigits = y.toString().split("");
  var productOfEachDigit = [];
  debug("bruteForceMultiplication x: " + x + " y: " + y);

  // N
  productOfEachDigit = yDigits.map(function(digit, i) {
    var value = x * digit;
    var tens = "";
    for (var j = yDigits.length - i - 1; j > 0; j--) {
      tens += "0";
    }
    var result = parseInt(value + tens, 10);
    debug(" multipling by " + digit + " and tens " + tens + " is " + result);
    return result;
  });

  // N
  return productOfEachDigit.reduce(function(acc, curr) {
    debug(" adding " + curr);
    return acc + curr;
  }, 0);
}

describe("Accumulation", function() {
  it("should return [24, 12, 8, 6]", function() {
    var result = productExceptSelfLinear([1, 2, 3, 4]);
    expect(result).toEqual([24, 12, 8, 6]);
    expect(productExceptSelfUsingNestedLoops([1, 2, 3, 4])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([1, 2, 3, 4])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([1, 2, 3, 4])).toEqual(result);
  });

  it("should support arbitrary numbers", function() {
    var result = productExceptSelfLinear([9, 22, 13, 8, 1, 3]);
    expect(result).toEqual([6864, 2808, 4752, 7722, 61776, 20592]);
    expect(productExceptSelfUsingNestedLoops([9, 22, 13, 8, 1, 3])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([9, 22, 13, 8, 1, 3])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([9, 22, 13, 8, 1, 3])).toEqual(result);
  });

  it("should support zero", function() {
    var result = productExceptSelfLinear([9, 22, 8, 1, 0]);
    expect(result).toEqual([0, 0, 0, 0, 1584]);
    expect(productExceptSelfUsingNestedLoops([9, 22, 8, 1, 0])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([9, 22, 8, 1, 0])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([9, 22, 8, 1, 0])).toEqual(result);
  });

  it("should be correct", function() {
    var result = bruteForceMultiplication(111, 22);
    expect(result).toEqual(2442);
  });

  it("should support 0", function() {
    var result = bruteForceMultiplication(111, 0);
    expect(result).toEqual(0);
    expect(bruteForceMultiplication(0, 111)).toEqual(0);
  });

  it("should support 1", function() {
    var result = bruteForceMultiplication(111, 1);
    expect(result).toEqual(111);
    expect(bruteForceMultiplication(1, 111)).toEqual(111);
  });

  it("should support arbitrary numbers", function() {
    var result = bruteForceMultiplication(823, 9234);
    expect(result).toEqual(7599582);
  });
});
