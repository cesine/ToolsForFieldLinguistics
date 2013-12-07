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

    console.log("\tRandom n:" + n + " start:" + start + " end:" + end + " result:" + ints);
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

    console.log("\tUnique n:" + n + " start:" + start + " end:" + end + " result:" + ints);
    return ints;
  };

  exports.measureRunTime = function(measureMe, args, runtimeHolder) {
    var start = Date.now();
    var result = measureMe.apply(this, args);
    runtimeHolder.runtime = Date.now() - start;
    console.log("Runtime: "+runtimeHolder.runtime);
    return result;
  };

}(typeof exports === 'object' && exports || this));