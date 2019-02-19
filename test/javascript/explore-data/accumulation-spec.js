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

function karatsubaMultiplication(x, y) {
  console.log("karatsubaMultiplication x: " + x + " y: " + y);

  var yDigits = y.toString().split("").map(function(val) {
    return parseInt(val, 10);
  });
  if (yDigits.length <= 2) {
    return x * y;
  }

  var xDigits = x.toString().split("").map(function(val) {
    return parseInt(val, 10);
  });
  if (xDigits.length <= 2) {
    return x * y;
  }

  console.log("  x length", xDigits.length);
  console.log("  y length", yDigits.length);
  var firstEndx = Math.ceil(xDigits.length / 2);
  var part1x = parseInt(xDigits.slice(0, firstEndx).join(""));
  var part2x = parseInt(xDigits.slice(firstEndx, xDigits.length).join(""));
  console.log("  part 1 x", part1x);
  console.log("  part 2 x", part2x);

  var firstEndy = Math.ceil(yDigits.length / 2);
  var part1y = parseInt(yDigits.slice(0, firstEndy).join(""));
  var part2y = parseInt(yDigits.slice(firstEndy, yDigits.length).join(""));
  console.log("  part 1 y", part1y);
  console.log("  part 2 y", part2y);

  // return karatsubaMultiplication(karatsubaMultiplication(part1x, part1y), karatsubaMultiplication(part2x, part2y))

  console.log("recursing", x, xDigits, y, yDigits);

  var ac = karatsubaMultiplication(part1x, part1y);
  var bd = karatsubaMultiplication(part2x, part2y);
  var abcd = karatsubaMultiplication((part1x + part2x), (part1y + part2y));
  var step4 = abcd - ac - bd;
  var result = ac * 10000 + bd + step4 * 100;
  console.log("   ac", ac);
  console.log("   bd", bd);
  console.log("   abcd", abcd, (part1x + part2x), (part1y + part2y));
  console.log("   step4", step4);
  console.log("   result", result);

  return result;
}

describe("Accumulation", function() {
  xit("should return [24, 12, 8, 6]", function() {
    var result = productExceptSelfLinear([1, 2, 3, 4]);
    expect(result).toEqual([24, 12, 8, 6]);
    expect(productExceptSelfUsingNestedLoops([1, 2, 3, 4])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([1, 2, 3, 4])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([1, 2, 3, 4])).toEqual(result);
  });

  xit("should support arbitrary numbers", function() {
    var result = productExceptSelfLinear([9, 22, 13, 8, 1, 3]);
    expect(result).toEqual([6864, 2808, 4752, 7722, 61776, 20592]);
    expect(productExceptSelfUsingNestedLoops([9, 22, 13, 8, 1, 3])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([9, 22, 13, 8, 1, 3])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([9, 22, 13, 8, 1, 3])).toEqual(result);
  });

  xit("should support zero", function() {
    var result = productExceptSelfLinear([9, 22, 8, 1, 0]);
    expect(result).toEqual([0, 0, 0, 0, 1584]);
    expect(productExceptSelfUsingNestedLoops([9, 22, 8, 1, 0])).toEqual(result);
    expect(productExceptSelfUsingNestedMap([9, 22, 8, 1, 0])).toEqual(result);
    expect(productExceptSelfUsingNestedReduce([9, 22, 8, 1, 0])).toEqual(result);
  });

  it("should be correct", function() {
    var result = bruteForceMultiplication(5678, 1234);
    expect(result).toEqual(7006652);
    // expect(karatsubaMultiplication(56 78, 12 34)).toEqual(7006652);

    // expect(karatsubaMultiplication(5, 1)).toEqual(5);

    // ac = 5 * 1; // 5
    // bd = 6 * 2; // 12
    // abcd = (5 + 6) * (1 + 2); // 22
    // step4 = abcd - ac - bd; // 5
    // result = ac * 100 + bd + step4 * 10;
    // expect(result).toEqual(672);
    // expect(karatsubaMultiplication(56, 12)).toEqual(672);

    var ac = 56 * 12; // 672
    var bd = 78 * 34; // 2652
    var abcd = (56 + 78) * (12 + 34); // 6164
    var step4 = abcd - ac - bd; // 2840
    result = ac * 10000 + bd + step4 * 100;
    expect(result).toEqual(7006652);
    expect(karatsubaMultiplication(5678, 1234)).toEqual(7006652);
    expect(karatsubaMultiplication(56789999, 12345678)).toEqual(701111041274322);
  });

  xit("should support 0", function() {
    var result = bruteForceMultiplication(111, 0);
    expect(result).toEqual(0);
    expect(bruteForceMultiplication(0, 111)).toEqual(0);
  });

  xit("should support 1", function() {
    var result = bruteForceMultiplication(111, 1);
    expect(result).toEqual(111);
    expect(bruteForceMultiplication(1, 111)).toEqual(111);
  });

  xit("should support arbitrary numbers", function() {
    var result = bruteForceMultiplication(823, 9234);
    expect(result).toEqual(7599582);
  });
});
