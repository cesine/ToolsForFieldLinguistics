/**
 * @param {number[]} dataPoints
 * @return {number}
 */
var maxArea = function(dataPoints) {
  console.log('dataPoints', dataPoints);


  // const tallest = dataPoints.sort((a, b) => b - a);
  const bestPoints = [];

  dataPoints.forEach((y, i) => {
    const current = {
      x: i + 1,
      y,
    };

    // optimization use a for loop so you can set the index start at
    // the current location
    //
    // also looping from the end would find the maxima best
    dataPoints.forEach((secondY, j) => {
      // only llok to points ahead
      if (j <= i ) {
        console.log('skip this', j, i)
        return;
      }
      const second = {
        x: j + 1,
        y: secondY,
      };

      console.log('first', current,' second', second )
      const bottomLength = second.x - current.x;
      const height = Math.min(current.y, second.y);
      const area = bottomLength * height;
      console.log('  bottomLength', bottomLength)
      console.log('  height', height)
      console.log('  area', area)

      if (!current.area || area > current.area) {
        current.area = area;
        current.end = { x: second.x, y: second.y}
      } else {
        console.log(`this area ${area} is not larger than the area so far for this point`, current)
      }

    });

    if (!bestPoints[0] || current.area > bestPoints[0].area) {
      bestPoints.unshift(current);
    } else {
      console.log('this is not hte best point', bestPoints[0], current);
    }
  });

  return bestPoints[0] && bestPoints[0].area;
};

describe("max area", function() {

  fit("should find the max area between two points", function() {
    // var result = maxArea([1, 8, 6]);
    var result = maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]);

    expect(result).toEqual(49);
  });
});
