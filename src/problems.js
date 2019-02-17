/*
Given an array of integers, return a new array of integers of the same size
where each number in the array is replaced with the product of all numbers in the array except itself.

For example: given the lists [1,2,3,4], the function should return [2*3*4, 1*3*4, 1*2*4, 1*2*3] -> [24, 12, 8, 6].
*/

function multiplyAll (numbers) {
  return numbers.map((position, i) => {
    let accum = 1;

    numbers.forEach((other, j) => {
      if (i === j) {
        return;
      }
      accum = accum * other;
    });

    return accum;
  });
}

module.exports = multiplyAll;
