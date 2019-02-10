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
