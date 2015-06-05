describe("Searching a matrix (table) of data...", function() {
	var tooSlowSeconds = 30;
	var debug = function() {
		return;
		console.log(arguments);
	};

	var fillMatrix = function(rows, columns, matrixHolder, placeholder, randomCharacter) {
		debug("fillMatrix " + rows + " " + columns, matrixHolder, placeholder);
		var checkForLongOperations = Date.now();

		if (columns === undefined) {
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
		matrixHolder = matrixHolder || [];
		placeholder = placeholder || "X";
		if (randomCharacter) {
			if (typeof randomCharacter === "string") {
				randomCharacter = {
					character: randomCharacter
				};
				randomCharacter.row = Math.floor(Math.random() * rows);
				randomCharacter.column = Math.floor(Math.random() * columns);
			}
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
				if (randomCharacter && randomCharacter.column === j) {
					if (randomCharacter && randomCharacter.row === i) {
						matrixHolder[i][j] = randomCharacter.character;
					}
				}
				debug("    Column " + i);
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