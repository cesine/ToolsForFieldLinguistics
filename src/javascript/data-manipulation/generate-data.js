/**
 * Utilities for generating (random) data for benchmarking and
 * exploring data
 *
 * @param  Object exports this is the object which will recieve the exports of this file
 */
(function(exports) {

  'use strict';


  /**
   * Fisher–Yates shuffling is similar to randomly picking numbered tickets 
   * (combinatorics: distinguishable objects) out of a hat without 
   * replacement until there are none left.
   *
   * It was reduced to run in linear O(n) time by Durstenfeld 1964
   
    for i from n − 1 downto 1 do
       j ← random integer with 0 ≤ j ≤ i
       exchange a[j] and a[i]

   * @param  Array shuffleMe an array to be shuffled
   */
  exports.durstenfeldShuffle = function durstenfeldShuffle(shuffleMe) {
    for (var i = 0; i < shuffleMe.length; i++) {
      var j = Math.floor((Math.random() * i));
      var temp = shuffleMe[j];
      shuffleMe[j] = shuffleMe[i];
      shuffleMe[i] = temp;
    }
  };


  exports.createArrayOfRandomIntegers = function(n, start, end, sameSequenceEveryTime) {
    if (!n || n < 0) {
      throw "n Must be a positive integer indicating the size of the array to be created";
    }

    start = start || 0;
    end = end || n;

    var randomSize = end - start + 1;
    var ints = [];
    for (var i = 0; i < n; i++) {
      ints.push(Math.floor(Math.random() * randomSize) + start);
    }

    console.log("\tRandom n:" + n + " start:" + start + " end:" + end + " result:");
    console.log("\t" + ints.length < 40 ? ints : "(too big)");
    return ints;
  };


  exports.createArrayOfRandomUniqueIntegers = function(n, start, end, sameSequenceEveryTime) {
    if (!n || n < 0) {
      throw "n Must be a positive integer indicating the size of the array to be created";
    }

    start = start || 0;
    end = end || n;

    /* Generate an array containing all the acceptable integers */
    var ints = [];
    for (var i = start; i <= end; i++) {
      ints.push(i);
    }

    /* Suffle the array */
    this.durstenfeldShuffle(ints);

    /* Truncate the array to only the requested size n */
    ints = ints.splice(0, n);

    console.log("\tUnique n:" + n + " start:" + start + " end:" + end + " result:");
    console.log("\t" + ints.length < 40 ? ints : "(too big)");
    return ints;
  };

  /**
   * This is an interesting approach to a unique problem. If you need to
   * sort a dense set of random integers who are only unique (or you dont
   * mind if you only get unique one back) then you can think of the integers
   * not as an array of integers, but more like a bitmap where 0 if the integer
   * is not present, and 1 if it is present. In this way the datastruture causes the data to
   * be sorted. What is interesting with this approach is that it shows how a
   * datastructure can be leveraged to reduce runtime.
   *
   * References: Bently 1986
   *
   * @param  Array sortMe an array of random integers
   * @param  int minValue an optional smallest value in the input array, otherwise assumed to be 0
   * @param  int maxValue an optional largest value in the input array, otherwise assumed to be the size of sortMe
   * @return Array        a sorted array of unique integers which were in sortMe
   */
  exports.sortRandomUniqueIntegers = function(sortMe, minValue, maxValue) {
    if (!sortMe) {
      throw "Cant sort: please pass an array to be sorted";
    }
    if (sortMe.length === 0 || sortMe.length === 1) {
      return sortMe;
    }

    /* assume the highest value is provided, or is the size of the array to be sorted 
     * TOOD maybe pickup the min and max from step 2 since this is javascript?
     */
    maxValue = maxValue || sortMe.length;
    minValue = minValue || 0;

    /* catch edge cases */
    if (minValue > maxValue) {
      throw "Cant sort: min:" + minValue + " is not less than max:" + maxValue;
    }
    if (minValue === maxValue) {
      return [minValue];
    }

    /* Step 1: initialize the integer space to 0:notfound for all possible ints (unnecesary in javascript)
      for (var i = minValue; i <= maxValue; i++) {
        bitMap[i] = 0;
      }
     */
    var bitMap = {};

    /* Step 2: if i is in the array, then set its bit to 1:found */
    for (var i = 0, l = sortMe.length; i < l; i++) {
      bitMap[sortMe[i]] = 1;
    }
    // console.log(bitMap);

    var result = [];
    var sparsityMeasure = 0;

    /* Step 3: convert the bitmap back into an array of integers */
    for (var i = minValue; i <= maxValue; i++) {
      if (bitMap[i] === 1) {
        result.push(i);
        // console.log(i);
        sparsityMeasure++;
      }
    }
    var range = maxValue - minValue;
    console.log("\tSort n:" + sortMe.length + " start:" + minValue + " end:" + maxValue + " Sparsity: " + sparsityMeasure / range * 100);
    return result;
  };

  exports.measureRunTime = function(measureMe, args, runtimeHolder) {
    var start = Date.now();
    var result = measureMe.apply(this, args);
    runtimeHolder.runtime = Date.now() - start;
    console.log("Runtime: " + runtimeHolder.runtime);
    return result;
  };

  exports.getUnique = function() {
    var unique = {}, a = [];
    for (var i = 0, l = this.length; i < l; ++i) {
      if (unique.hasOwnProperty(this[i])) {
        continue;
      }
      a.push(this[i]);
      unique[this[i]] = 1;
    }
    return a;
  };

}(typeof exports === 'object' && exports || this));