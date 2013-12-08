'use strict';

var generateData = require('../../src/javascript/data-manipulation/generate-data.js');

describe("Generating data...", function() {

  it("should be able to measure the runtime of a function", function() {
    var measureMeExponetiallySlow = function(max, dataHolder) {
      console.log("\tmeasureMeExponetiallySlow max:" + max);
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

    /* If it was unmeasureably fast, try again with 10 times more data */
    if (runtimeHolder.runtime === 0) {
      max = max * 10;
      resultOfExpSlow = generateData.measureRunTime(measureMeExponetiallySlow, [max, dataHolder], runtimeHolder);
    }
    expect(resultOfExpSlow.length > 0).toBe(true);

    // console.log(runtimeHolder.runtime);
    expect(runtimeHolder.runtime > 0).toBe(true);
  });

  it("should throw an error if the array size isn't a valid size", function() {
    try {
      var missingSize = generateData.createArrayOfRandomIntegers();
      expect(missingSize).toBe(undefined);
    } catch (e) {
      expect(e).toBeDefined();
    }

    try {
      var negativeSize = generateData.createArrayOfRandomIntegers(-2);
      expect(negativeSize).toBe(undefined);
    } catch (e) {
      expect(e).toBeDefined();
    }
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

    n = 2000;
    var runtimeHolder = {};
    var resultSmallWithEnd = generateData.measureRunTime(generateData.createArrayOfRandomIntegers, [n, 0, n], runtimeHolder);
    expect(resultSmallWithEnd.length).toBe(n);
  });

  it("should create an n sized array of unique ints", function() {
    var n = 5;
    var small = generateData.createArrayOfRandomUniqueIntegers(n);
    expect(small.length).toBe(n);

    var smallWithEnd = generateData.createArrayOfRandomUniqueIntegers(n, -2, n);
    expect(smallWithEnd.length).toBe(n);

    n = 20000;
    var runtimeHolder = {};
    var resultSmallWithEnd = generateData.measureRunTime(generateData.createArrayOfRandomUniqueIntegers, [n, 0, n], runtimeHolder);
    expect(resultSmallWithEnd.length).toBe(n);

    resultSmallWithEnd.getUnique = generateData.getUnique;
    var uniqueOnly = resultSmallWithEnd.getUnique();
    expect(uniqueOnly.length === resultSmallWithEnd.length).toBe(true);
  });

  it("should create a file between 0 and 27,000 unique integers in random order", function() {
    var n = 27000;
    var medium = generateData.createArrayOfRandomUniqueIntegers(n);
    console.log(medium);
    expect(medium.length).toBe(n);
  });

  it("should sort 0 and 27,000 unique random integers in using less than 16000 bits", function() {
    expect(true).toBe(true);
  });



});