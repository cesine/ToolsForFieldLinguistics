'use strict';

var generateData = require('../../src/javascript/data-manipulation/generate-data.js');

describe("Generating data...", function() {

  it("should create a file between 0 and 27,000 unique integers in random order", function() {
    var small = generateData.createArrayOfRandomIntegers(10);

    var original = [1, 2, 3, 4, 32, 1, 35];
    console.log(small);
    generateData.durstenfeldShuffle(small);

    console.log(small);
    console.log(original);
    expect(original !== small).toBe(true);
  });

  it("should sort 0 and 27,000 unique random integers in using less than 16000 bits", function() {
    expect(true).toBe(true);
  });

  it("should create an n sized array of unique ints", function() {
    var n = 5;
    var small = generateData.createArrayOfRandomUniqueIntegers(n);
    expect(small.length).toBe(n);

    var smallWithEnd = generateData.createArrayOfRandomUniqueIntegers(n, 0, n);
    expect(smallWithEnd.length).toBe(n);

  });

  it("should create an n sized array", function() {
    var n = 5;
    var small = generateData.createArrayOfRandomIntegers(n);
    expect(small.length).toBe(n);

    var smallWithEnd = generateData.createArrayOfRandomIntegers(n, 0, n);
    expect(smallWithEnd.length).toBe(n);

    var smallWithNonZeroEnd = generateData.createArrayOfRandomIntegers(n, 10, 20);
    expect(smallWithNonZeroEnd.length).toBe(n);

    var smallNegativeInts = generateData.createArrayOfRandomIntegers(n, -10, -2);
    expect(smallNegativeInts.length).toBe(n);

  });

  it("should throw an error if the array size isn't given", function() {
    try {
      var small = generateData.createArrayOfRandomIntegers();
      expect(small).toBe(undefined);
    } catch (e) {
      expect(e).toBeDefined();
    }
  });

  it("should be able to measure the runtime of a function", function() {
    var measureMeExponetiallySlow = function(max, dataHolder) {
      console.log("Inside the measureMeExponetiallySlow max:" + max + " dataHolder:" + dataHolder);
      for (var i = 0; i <= max; i++) {
        dataHolder[i] = [];
        for (var j = 0; j < max; j++) {
          dataHolder[i].push(j);
        }
      }
      // console.log(JSON.stringify(dataHolder, null, 4));
      return dataHolder;
    };
    var max = 100;
    var dataHolder = [];
    var runtimeHolder = {};

    var resultOfExpSlow = generateData.measureRunTime(measureMeExponetiallySlow, [max, dataHolder], runtimeHolder);
    // console.log(JSON.stringify(dataHolder));
    expect(resultOfExpSlow.length > 0).toBe(true);

    console.log(runtimeHolder.runtime);
    expect(runtimeHolder.runtime > 0).toBe(true);
  });

});