(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
/**
 * ToolsForFieldLinguistics
 * A collection of scripts and recpies for fieldlinguistics and for RAs in data heavy labs
 *
 * https://github.com/cesine/ToolsForFieldLinguistics
 *
 * Copyright (c) 2010-2019 cesine
 * Licensed under the Apache 2.0 license.
 *
 * @module          ToolsForFieldLinguistics
 * @tutorial        test/javascript/ToolsForFieldLinguistics-spec.js
 * @requires        GenerateData
 */
var GenerateData = require("./data-manipulation/generate-data");

(function(exports) {

  "use strict";

  exports.init = function() {
    return "init";
  };
  exports.GenerateData = GenerateData;

}(typeof exports === "object" && exports || this));

},{"./data-manipulation/generate-data":2}],2:[function(require,module,exports){
/**
 * Utilities for generating (random) data for benchmarking and
 * exploring data.
 *
 *
 * @module  GenerateData
 * @extends {AnyObject}
 * @tutorial  test/javascript/generate-data-spec.js
 * @param   exports Object this is the object which will recieve the exports of this file
 */
(function(exports) {

  "use strict";

  var debug = function() {
    // console.log(arguments);
    return;
  };

  /**
   * Fisher–Yates shuffling is similar to randomly picking numbered tickets
   * (combinatorics: distinguishable objects) out of a hat without
   * replacement until there are none left. <p>
   *
   * It was reduced to run in linear O(n) time by Durstenfeld 1964 by looping through
   * the array just once O(n) and at each index, finding a random other index in the
   * array to swap places with.
   *
    <pre>
    Pseudocode
    for i from n − 1 downto 1 do
       j ← random integer with 0 ≤ j ≤ i
       exchange a[j] and a[i]
    </pre>

   * @param {Array} shuffleMe An array to be shuffled
   * @return {this}           This, for chaining other operations.
   */
  exports.shuffle = function shuffle(shuffleMe) {
    for (var i = 0; i < shuffleMe.length; i++) {
      var j = Math.floor((Math.random() * i));
      var temp = shuffleMe[j];
      shuffleMe[j] = shuffleMe[i];
      shuffleMe[i] = temp;
    }
    return this;
  };

  /**
   * Create an array of random numbers can be used to create data which can be reused later for
   * debugging sorting algorithms and improving the runtime of your data crunching. <p>
   *
   * If you want to have unique integers, see createArrayOfRandomUniqueIntegers below.
   *
   *
   * @param  {int} n     The size of the array to be creatd
   * @param  {int} start An optional minimal value, otherwise assumed to be 0
   * @param  {int} end   An optional maximal value, otherwise assumed to be n
   * @return {Array}       An array of random unique integers
   */
  exports.createArrayOfRandomIntegers = function(n, start, end) {
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

    debug("\tRandom n:" + n + " start:" + start + " end:" + end + " result:");
    debug("\t" + ints.length < 40 ? ints : "(too big)");
    return ints;
  };


  /**
   * Create an array of random unique numbers can be used to create data which can be reused later for
   * debugging sorting algorithms and improving the runtime of your data crunching.
   *
   *
   * @param  {int} n     The size of the array to be creatd
   * @param  {int} start An optional minimal value, otherwise assumed to be 0
   * @param  {int} end   An optional maximal value, otherwise assumed to be n
   * @return {Array}       An array of random unique integers
   */
  exports.createArrayOfRandomUniqueIntegers = function(n, start, end) {
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
    this.shuffle(ints);

    /* Truncate the array to only the requested size n */
    ints = ints.splice(0, n);

    debug("\tUnique n:" + n + " start:" + start + " end:" + end + " result:");
    debug("\t" + ints.length < 40 ? ints : "(too big)");
    return ints;
  };

  /**
   * This is an interesting approach to a unique problem. If you need to
   * sort a dense set of random integers who are only unique (or you don't
   * mind if you only get unique one back) then you can think of the integers
   * not as an array of integers, but more like a bitmap where 0 if the integer
   * is not present, and 1 if it is present. <p>
   *
   * In this way the datastruture causes the data to
   * be sorted. What is interesting with this approach is that it shows how a
   * datastructure can be leveraged to reduce runtime.<p>
   *
   * References: Bently 1986
   *
   * @param {Array} sortMe    An array of random integers
   * @param {int}   minValue  An optional smallest value in the input array, otherwise assumed to be 0
   * @param {int}  maxValue   An optional largest value in the input array, otherwise assumed to be the size of sortMe
   * @return {Array}          A sorted array of unique integers which were in sortMe
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
    // debug(bitMap);

    var result = [];
    var sparsityMeasure = 0;

    /* Step 3: convert the bitmap back into an array of integers */
    for (var j = minValue; j <= maxValue; j++) {
      if (bitMap[j] === 1) {
        result.push(j);
        // debug(i);
        sparsityMeasure++;
      }
    }
    var range = maxValue - minValue;
    debug("\tSort n:" + sortMe.length + " start:" + minValue + " end:" + maxValue + " Sparsity: " + sparsityMeasure / range * 100);
    return result;
  };

  exports.measureRunTime = function(measureMe, args, runtimeHolder) {
    var start = Date.now();
    var result = measureMe.apply(this, args);
    runtimeHolder.runtime = Date.now() - start;
    debug("Runtime: " + runtimeHolder.runtime);
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

}(typeof exports === "object" && exports || this));

},{}]},{},[1]);
