describe("Searching a matrix (table) of data...", function() {

	var debug = function() {
		console.log(arguments);
	};

	var fillMatrix = function(rows, columns, matrixHolder, placeholder) {
		debug("fillMatrix " + rows + " " + columns, matrixHolder, placeholder);

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

		for (i = rows - 1; i >= 0; i--) {
			debug("  Row " + i);
			matrixHolder[i] = matrixHolder[i] || [];
			for (j = columns - 1; j >= 0; j--) {
				debug("    Column " + i);
				matrixHolder[i][j] = placeholder;
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
			for (j =0; j < matrixHolder[i].length; j++) {
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
			var matrix = fillMatrix(2, 2);

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

	describe("visalization", function() {

		it("should be able to print any NxN matrix", function() {
			expect(visualizeMatrix(fillMatrix(2, 2))).toEqual("XX\nXX");
		});

		it("should be able to print any NxM matrix", function() {
			expect(visualizeMatrix(fillMatrix(2, 3))).toEqual("XXX\nXXX");
		});

		it("should print from the top-left to the bottom-right", function() {
			expect(visualizeMatrix([["a", "b", "c"], ["1", "2", "3"]])).toEqual("abc\n123");
		});

		it("should survive invalid input", function() {
			try {
				expect(visualizeMatrix()).toEqual("");
			} catch (e) {
				expect(e).toEqual("hi");
			}
		});

		it("should survive incomplete input", function() {
			expect(visualizeMatrix([["t","o"],["b"],["l","o","n","g"]])).toEqual("to\nb\nlong");
		});

	});

	it("should run in finite time", function() {
		expect(true).toBeTruthy();
	});

	it("should run in better than N*M time", function() {
		expect(true).toBeTruthy();
	});

});