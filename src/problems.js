/*
Given an array of integers, return a new array of integers of the same size
where each number in the array is replaced with the product of all numbers in the array except itself.

For example: given the lists [1,2,3,4], the function should return [2*3*4, 1*3*4, 1*2*4, 1*2*3] -> [24, 12, 8, 6].
*/

module.exports = function productExceptIndex(input) {
  // Accumulate products of values to the right
  const right = [1];
  for (let i = input.length - 1; i > 0; i--) {
    right.unshift(right[0] * input[i]);
  }
  console.log('right', right);

  // Accumulate products of values to the left
  const left = [1];
  for (let i = 0; i < input.length - 1; i++) {
    left.push(left[i] * input[i]);
  }
  console.log('left', left);

  // Multiply right and left
  return input.map(function(val, i) {
    return right[i] * left[i];
  });
};
