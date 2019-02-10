"use strict";

/**
 * GenerateData specs for testing the generation of random data, including uniqueness sorting shuffling and runtime.
 *
 * @requires GenerateData
 * @requires Jasmine
 *
 * @example  GenerateData
 * @module  GenerateData-specs
 */
var generateData = require("../../src/javascript/data-manipulation/generate-data.js");

var debug = function() {
  // console.log(arguments);
  return;
};

describe("Generating data...", function() {

  beforeEach(function() {
    // console.log("--------------------------------------------------");
  });

  it("should be able to measure the runtime of a function", function() {
    var measureMeExponetiallySlow = function(max, dataHolder) {
      debug("\tmeasureMeExponetiallySlow max:" + max);
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

    /* If it was unmeasureably fast, try again with twice as much data */
    if (runtimeHolder.runtime === 0) {
      max = max * 2;
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

  it("should sort random unique signed integers", function() {
    var n = 200;
    var min = -100;
    var max = 200;
    var start = Date.now();
    var medium = generateData.createArrayOfRandomUniqueIntegers(n, min, max);
    debug("Runtime for generating " + n + " unique signed integers: ", Date.now() - start);
    expect(medium.length).toBe(n);

    start = Date.now();
    var sortedMedium = generateData.sortRandomUniqueIntegers(medium, min, max);
    debug("Runtime for sorting " + n + " unique signed integers: ", Date.now() - start);

    expect(sortedMedium.length).toBe(n);
  });

  it("should sort 0 and 27,000 random unique integers", function() {
    var n = 27000;
    var start = Date.now();
    var medium = generateData.createArrayOfRandomUniqueIntegers(n, 0, n);
    debug("Runtime for generating " + n + " unique integers: ", Date.now() - start);
    expect(medium.length).toBe(n);
    start = Date.now();
    var sortedMedium = generateData.sortRandomUniqueIntegers(medium, 0, n);
    debug("Runtime for sorting " + n + " unique integers: ", Date.now() - start);

    expect(sortedMedium.length).toBe(n);
  });

  it("should sort random unique integers in linear time", function() {
    var n = 1000000;
    var linearFactor = 2;
    var medium = generateData.createArrayOfRandomUniqueIntegers(n, 0, n);
    var start = Date.now();
    var sortedMedium = generateData.sortRandomUniqueIntegers(medium, 0, n);
    var runtime1 = Date.now() - start;
    expect(sortedMedium.length).toBe(n);

    var n2 = n * linearFactor;
    start = Date.now();
    var large = generateData.createArrayOfRandomUniqueIntegers(n2, 0, n2);
    var sortedLarge = generateData.sortRandomUniqueIntegers(large, 0, n2);
    var runtime2 = Date.now() - start;
    expect(sortedLarge.length).toBe(n2);
    expect(runtime2).toBeGreaterThan(0);

    var n3 = n2 * linearFactor;
    start = Date.now();
    var xLarge = generateData.createArrayOfRandomUniqueIntegers(n3, 0, n3);
    var sortedXLarge = generateData.sortRandomUniqueIntegers(xLarge, 0, n3);
    var runtime3 = Date.now() - start;
    expect(sortedXLarge.length).toBe(n3);

    debug("Runtime for sorting " + n + " unique integers: ", runtime1);
    debug("Runtime for sorting " + n2 + " unique integers: ", runtime2);
    debug("Runtime for sorting " + n3 + " unique integers: ", runtime3);

    if (runtime1 === 0) {
      runtime1 = 0.1;
    }
    if (runtime2 === 0) {
      runtime2 = 0.1;
    }
    var firstFactor = runtime2 / runtime1;
    var secondFactor = runtime3 / runtime2;
    var factorDifference = secondFactor - firstFactor;
    debug("Expected factor: ~" + linearFactor);
    debug("Factor in first leap: " + firstFactor + " factor in second leap: " + secondFactor + " velocity: " + factorDifference);
    var acceptableVariance = 1;
    expect(factorDifference).toBeLessThan(acceptableVariance);

    var exponentialTime = linearFactor * linearFactor;
    expect(firstFactor).toBeLessThan(exponentialTime);
    expect(secondFactor).toBeLessThan(exponentialTime);
    var exponent = Math.log2(runtime2/runtime1);
    debug(exponent);
    expect(Math.round(exponent)).toEqual(2);
  });


});
