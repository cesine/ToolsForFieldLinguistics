// 3 - Write a function that return a array of number that multiply all except itself.
// For example: given the lists [1,2,3,4], the function should return [2*3*4, 1*3*4, 1*2*4, 1*2*3] -> [24, 12, 8, 6].


function multiplyAll (numbers) {
  console.log('args', numbers);
  return numbers.map((position) => {
    let accum = 1;

    numbers.forEach((other) => {
      if (other === position) {
        return;
      }
      accum = accum * other;
    });
    return accum;
  });
}

module.exports = {
  multiplyAll
};
