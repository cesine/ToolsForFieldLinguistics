describe("Searching a matrix (table) of data...", function() {
  var tooSlowSeconds = 30;
  var debug = function() {
    return;
    console.log(arguments);
  };

  var fillMatrix = function(rows, columns, matrixHolder, placeholder, randomCharacters) {
    debug("fillMatrix " + rows + " " + columns, matrixHolder, placeholder);
    var checkForLongOperations = Date.now();

    if (columns === undefined || columns === null) {
      columns = rows;
    }
    var errors = "";
    if (rows <= 0) {
      errors = errors + "Cannot create matrix with negative or zero (" + rows + ") height.";
    }
    if (columns <= 0) {
      errors = errors + " Cannot create matrix with negative or zero (" + columns + ") width.";
    }
    if (errors) {
      throw new Error(errors);
    }

    var i;
    var j;
    var custom;
    var randomCharacter;

    matrixHolder = matrixHolder || [];
    placeholder = placeholder || "X";
    if (randomCharacters) {
      if (typeof randomCharacters === "string") {
        randomCharacters = {
          character: randomCharacters
        };
        randomCharacters.row = Math.floor(Math.random() * rows);
        randomCharacters.column = Math.floor(Math.random() * columns);
      }
      if (Object.prototype.toString.call(randomCharacters) !== "[object Array]") {
        randomCharacters = [randomCharacters];
      }
    } else {
      randomCharacters = [];
    }

    for (i = 0; i < rows; i++) {
      debug("  Row " + i);
      matrixHolder[i] = matrixHolder[i] || [];
      for (j = 0; j < columns; j++) {
        if (j % 100 === 0 && i % 100 === 0) {
          if ((Date.now() - checkForLongOperations) / 1000 > tooSlowSeconds) {
            throw new Error("Operation is running too slow: " + (Date.now() - checkForLongOperations) / 1000 + " seconds for " + rows + "BY" + columns);
          } else {
            debug("Still running " + j, (Date.now() - checkForLongOperations) / 1000);
          }
        }
        matrixHolder[i][j] = placeholder;
        for (custom = 0; custom < randomCharacters.length; custom++) {
          randomCharacter = randomCharacters[custom];
          if (randomCharacter && randomCharacter.column === j) {
            if (randomCharacter && randomCharacter.row === i) {
              matrixHolder[i][j] = randomCharacter.character;
            }
          }
        }
        debug("  Column " + i);
      }
    }

    return matrixHolder;
  };

  var visualizeMatrix = function(matrixHolder, linebreak) {
    debug("visualizeMatrix " + matrixHolder + " " + linebreak);

    if (!matrixHolder) {
      return "";
    }
    var i;
    var j;
    var visual = "";
    var row;

    linebreak = linebreak || "\n";
    for (i = 0; i < matrixHolder.length; i++) {
      row = "";
      for (j = 0; j < matrixHolder[i].length; j++) {
        row = row + matrixHolder[i][j];
      }
      visual = (visual ? (visual + linebreak) : "") + row;
    }

    debug(visual);
    return visual;
  };

  var findInMatrix = function(matrix, findCharacter, exaustive) {
    var i;
    var j;
    var matches = [];

    for (i = 0; i < matrix.length; i++) {
      debug("  Row " + i);
      for (j = 0; j < matrix[0].length; j++) {
        debug("    Column " + j);
        if (matrix[i][j] === findCharacter) {
          matches.push({
            character: matrix[i][j],
            row: i,
            column: j
          });
        }
      }
    }
    if (exaustive) {
      return matches[0] ? matches : null;
    }
    return matches[0] ? matches[0] : null;
  };

  var tracePath = function(matrix, findCharacter, fromCharacter, exaustive) {
    var location = findInMatrix(matrix, findCharacter, exaustive);
    if (!location) {
      return;
    }
    if (fromCharacter) {
      if (typeof fromCharacter === "string") {
        fromCharacter = findInMatrix(matrix, fromCharacter, exaustive);
      }
    } else {
      fromCharacter = {
        row: 0,
        column: 0,
        character: matrix[0][0]
      };
    }

    var path = [];
    var i;
    var j;

    for (i = fromCharacter.row; i < location.row; i++) {
      path.push("DOWN");
    }
    for (j = fromCharacter.column; j < location.column; j++) {
      path.push("RIGHT");
    }

    return path;
  };

  beforeEach(function() {
    console.log("--------------------------------------------------");
  });

  describe("construction", function() {

    it("should accept any NxN matrix", function() {
      var matrix = fillMatrix(2);

      expect(matrix.length).toEqual(2);
      expect(matrix[0].length).toEqual(2);
    });


    it("should accept any NxM matrix", function() {
      var matrix = fillMatrix(8, 5);

      expect(matrix.length).toEqual(8);
      expect(matrix[0].length).toEqual(5);
    });

    it("should survive invalid height", function() {
      try {
        expect(fillMatrix(-2, 4)).toEqual("");
      } catch (e) {
        expect(e.message).toEqual("Cannot create matrix with negative or zero (-2) height.");
      }
    });

    it("should survive invalid width", function() {
      try {
        expect(fillMatrix(9, 0)).toEqual("");
      } catch (e) {
        expect(e.message).toEqual(" Cannot create matrix with negative or zero (0) width.");
      }
    });

    it("should survive invalid height and width", function() {
      try {
        expect(fillMatrix(-7, -9)).toEqual("");
      } catch (e) {
        expect(e.message).toEqual("Cannot create matrix with negative or zero (-7) height. Cannot create matrix with negative or zero (-9) width.");
      }
    });

  });

  describe("contents", function() {

    it("should be able to put a custom placeholder any matrix", function() {
      expect(visualizeMatrix(fillMatrix(2, 2, null, "0"))).toEqual("00\n00");
    });

    it("should be able to put a random character in any matrix", function() {
      expect(visualizeMatrix(fillMatrix(2, 2, null, "0", "p"))).not.toEqual("00\n00");
      expect(visualizeMatrix(fillMatrix(4, 5, null, ".", {
        character: "∆",
        row: 3,
        column: 1
      }))).toEqual('.....\n.....\n.....\n.∆...');
    });

  });

  describe("visalization", function() {

    it("should be able to print any NxN matrix", function() {
      expect(visualizeMatrix(fillMatrix(2, 2))).toEqual("XX\nXX");
    });

    it("should be able to print any NxM matrix", function() {
      expect(visualizeMatrix(fillMatrix(2, 3))).toEqual("XXX\nXXX");
    });

    it("should print from the top-left to the bottom-right", function() {
      expect(visualizeMatrix([
        ["a", "b", "c"],
        ["1", "2", "3"]
      ])).toEqual("abc\n123");
    });

    it("should survive invalid input", function() {
      try {
        expect(visualizeMatrix()).toEqual("");
      } catch (e) {
        expect(e).toEqual("hi");
      }
    });

    it("should survive incomplete input", function() {
      expect(visualizeMatrix([
        ["t", "o"],
        ["b"],
        ["l", "o", "n", "g"]
      ])).toEqual("to\nb\nlong");
    });

  });

  describe("search", function() {

    it("should be able to find a matching element in finite time", function() {
      var characterToSearchFor = "P";
      var matrix = fillMatrix(10, null, null, "X", {
        character: characterToSearchFor,
        row: 9,
        column: 7
      });
      console.log(matrix);
      expect(matrix).toBeDefined();

      var locationOfCharacter = findInMatrix(matrix, characterToSearchFor);
      expect(locationOfCharacter).toBeDefined();
      expect(locationOfCharacter.character).toEqual(characterToSearchFor);
      expect(locationOfCharacter.row).toEqual(9);
      expect(locationOfCharacter.column).toEqual(7);

    });

  });


  describe("path", function() {

    it("should be able to find a the shortest path to an element in finite time", function() {
      var characterToSearchFor = "P";
      var path = tracePath(fillMatrix(10, null, null, "X", {
        character: characterToSearchFor,
        row: 9,
        column: 7
      }), characterToSearchFor);

      expect(path).toBeDefined();
      expect(path.length).toEqual(16);

    });

    it("should be able to find a the shortest path between two elements in finite time", function() {
      var characterToSearchFor = "P";
      var characterToSearchFrom = "M";
      var matrix = fillMatrix(10, null, null, ".", [{
        character: characterToSearchFor,
        row: 9,
        column: 7
      }, {
        character: characterToSearchFrom,
        row: 2,
        column: 0
      }]);

      var path = tracePath(matrix, characterToSearchFor, characterToSearchFrom);

      expect(path).toBeDefined();
      expect(path.length).toEqual(14);

    });

  });

  describe("performance", function() {

    xit("should run in finite time", function() {
      try {
        fillMatrix(Infinity);
        expect(false).toEqual("run out of time");
      } catch (e) {
        expect(e.message).toBeDefined();
        expect(e.message).toContain("Operation is running too slow:");
      }
    });

    it("should run in better than N*M time", function() {
      var startTime;
      var samples = [];
      var size = 500;
      var k;

      var matrix = []; // without assignment to go faster
      for (k = 1; k < 5; k++) {
        startTime = Date.now();
        fillMatrix(size * k, size * k, matrix);
        samples.push((Date.now() - startTime));
      }

      console.log(samples);

      expect(samples[0]).toBeGreaterThan(0);
      expect(samples[1]).toBeGreaterThan(0);
      expect(samples[2]).toBeGreaterThan(0);
      expect(samples[3]).toBeGreaterThan(0);

      expect(samples[1]).toBeGreaterThan(samples[0]);
      expect(samples[2]).toBeGreaterThan(samples[1]);
      expect(samples[3]).toBeGreaterThan(samples[2]);

      expect(samples[1]).toBeLessThan(samples[0] * samples[0]);
      expect(samples[2]).toBeLessThan(samples[1] * samples[1]);
      expect(samples[3]).toBeLessThan(samples[2] * samples[2]);
    });

  });

});